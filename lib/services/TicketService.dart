import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insync/model/project.dart';
import 'package:insync/model/ticket.dart';
import 'package:insync/model/user.dart';
import 'package:insync/services/ProjectService.dart';

class TicketService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ProjectService _projectService = ProjectService();

  //helper that points to the tickets subcollection of a project
  //organizations/{orgId}/projects/{projId}/tickets
  CollectionReference<Map<String, dynamic>> _ticketsRef(
    String orgId,
    String projId,
  ) {
    return _db
        .collection('organizations')
        .doc(orgId)
        .collection('projects')
        .doc(projId)
        .collection('tickets');
  }

  //---------------
  //the Ticket model holds a full Project and full UserModels ,
  //but firestore only saves their ids , so this helper reads them back
  //and builds the Ticket model
  //usersCache is shared between tickets so the same user is not read twice
  Future<Ticket> _ticketFromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
    Project project,
    Map<String, UserModel> usersCache,
  ) async {
    final data = doc.data()!;

    final assignedBy = await _getUser(data['assignedBy'], usersCache);

    final List<UserModel> assignedTo = [];
    for (final uid in List<String>.from(data['assignedToIds'] ?? [])) {
      assignedTo.add(await _getUser(uid, usersCache));
    }

    return Ticket(
      doc.id,
      project,
      Priority.values.byName(data['priority']), //saved as string
      data['title'],
      data['description'],
      (data['dueDate'] as Timestamp).toDate(), //saved as Firestore Timestamp
      (data['lastUpdated'] as Timestamp).toDate(),
      (data['creationDate'] as Timestamp).toDate(),
      assignedBy,
      assignedTo,
      data['isConfirmed'] ?? false,
    );
  }

  //reads a user from the users collection , or from the cache if read before
  Future<UserModel> _getUser(
    String uid,
    Map<String, UserModel> usersCache,
  ) async {
    if (usersCache.containsKey(uid)) {
      return usersCache[uid]!;
    }
    final doc = await _db.collection('users').doc(uid).get();
    final user = UserModel.fromMap(doc.data()!, doc.id);
    usersCache[uid] = user;
    return user;
  }

  //reads a project doc and turns it into a model
  Future<Project> _getProject(DocumentReference<Map<String, dynamic>> projRef) async {
    final doc = await projRef.get();
    return Project.fromMap(doc.data()!, doc.id);
  }

  //---------------
  //creates a new ticket inside the project , returns the new ticket id
  //meetingId is optional , only tickets made by the ai from a meeting have it
  Future<String> createTicket(
    String orgId,
    String projId,
    String title,
    String description,
    Priority priority,
    DateTime dueDate,
    String assignedBy,         // uid of the one who made the ticket
    List<String> assignedTo,   // uids of the employees
    bool isConfirmed,          // false when the ai makes it , true when a person makes it
    {String? meetingId}
  ) async {
    final ticketRef = _ticketsRef(orgId, projId).doc(); // auto ID of ticket
    final now = DateTime.now();

    await ticketRef.set({
      'ticketId': ticketRef.id,
      'orgId': orgId,
      'projId': projId,
      'title': title,
      'description': description,
      'priority': priority.name,
      'status': 'todo',        // todo -> inProgress -> done
      'dueDate': Timestamp.fromDate(dueDate),
      'creationDate': Timestamp.fromDate(now),
      'lastUpdated': Timestamp.fromDate(now),
      'assignedBy': assignedBy,
      'assignedToIds': assignedTo,
      'isConfirmed': isConfirmed,
      'meetingId': meetingId,
    });

    //a new ticket changes the done / all ratio
    await _projectService.recalculateProgression(orgId, projId);

    return ticketRef.id;
  }

  //---------------
  //gets every ticket assigned to this user from all projects
  //collectionGroup searches every "tickets" subcollection at once
  //only confirmed tickets , the unconfirmed ones are still waiting for review
  Future<List<Ticket>> getMyTickets(String uid) async {
    final result = await _db
        .collectionGroup('tickets')
        .where('assignedToIds', arrayContains: uid)
        .where('isConfirmed', isEqualTo: true)
        .get();

    final usersCache = <String, UserModel>{};
    final projectsCache = <String, Project>{};
    final List<Ticket> tickets = [];

    for (final doc in result.docs) {
      //tickets/{ticketId} -> parent is the tickets collection -> its parent is the project doc
      final projRef = doc.reference.parent.parent!;
      projectsCache[projRef.path] ??= await _getProject(projRef);

      tickets.add(await _ticketFromDoc(doc, projectsCache[projRef.path]!, usersCache));
    }

    return tickets;
  }

  //---------------
  //gets all the tickets of one project (confirmed and unconfirmed)
  Future<List<Ticket>> getProjectTickets(String orgId, String projId) async {
    final ticketsRef = _ticketsRef(orgId, projId);
    final result = await ticketsRef.get();

    final project = await _getProject(ticketsRef.parent!);
    final usersCache = <String, UserModel>{};

    final List<Ticket> tickets = [];
    for (final doc in result.docs) {
      tickets.add(await _ticketFromDoc(doc, project, usersCache));
    }
    return tickets;
  }

  //---------------
  //gets the tickets the ai made that nobody confirmed yet
  Future<List<Ticket>> getUnconfirmedTickets(String orgId, String projId) async {
    final ticketsRef = _ticketsRef(orgId, projId);
    final result =
        await ticketsRef.where('isConfirmed', isEqualTo: false).get();

    final project = await _getProject(ticketsRef.parent!);
    final usersCache = <String, UserModel>{};

    final List<Ticket> tickets = [];
    for (final doc in result.docs) {
      tickets.add(await _ticketFromDoc(doc, project, usersCache));
    }
    return tickets;
  }

  //---------------
  //changes the status (todo , inProgress , done) then updates the project progression
  Future<void> updateStatus(
    String orgId,
    String projId,
    String ticketId,
    String status,
  ) async {
    await _ticketsRef(orgId, projId).doc(ticketId).update({
      'status': status,
      'lastUpdated': Timestamp.now(),
    });

    await _projectService.recalculateProgression(orgId, projId);
  }

  //---------------
  //edits the main info of the ticket
  Future<void> updateTicket(
    String orgId,
    String projId,
    String ticketId,
    String title,
    String description,
    Priority priority,
    DateTime dueDate,
  ) async {
    await _ticketsRef(orgId, projId).doc(ticketId).update({
      'title': title,
      'description': description,
      'priority': priority.name,
      'dueDate': Timestamp.fromDate(dueDate),
      'lastUpdated': Timestamp.now(),
    });
  }

  //---------------
  //replaces the employees assigned to the ticket
  Future<void> reassign(
    String orgId,
    String projId,
    String ticketId,
    List<String> assignedTo,
  ) async {
    await _ticketsRef(orgId, projId).doc(ticketId).update({
      'assignedToIds': assignedTo,
      'lastUpdated': Timestamp.now(),
    });
  }

  //---------------
  //confirms (or unconfirms) a ticket the ai made
  Future<void> confirmTicket(
    String orgId,
    String projId,
    String ticketId,
    bool isConfirmed,
  ) async {
    await _ticketsRef(orgId, projId).doc(ticketId).update({
      'isConfirmed': isConfirmed,
      'lastUpdated': Timestamp.now(),
    });
  }

  //---------------
  //deletes the ticket then updates the project progression
  Future<void> deleteTicket(
    String orgId,
    String projId,
    String ticketId,
  ) async {
    await _ticketsRef(orgId, projId).doc(ticketId).delete();

    await _projectService.recalculateProgression(orgId, projId);
  }
}
