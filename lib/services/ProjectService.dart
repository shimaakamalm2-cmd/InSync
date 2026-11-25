import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insync/model/project.dart';
import 'package:insync/model/user.dart';

class ProjectService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //helper that points to the projects subcollection of an org
  //organizations/{orgId}/projects
  CollectionReference<Map<String, dynamic>> _projectsRef(String orgId) {
    return _db.collection('organizations').doc(orgId).collection('projects');
  }

  //---------------
  //creates a new project inside the org , returns the new project id
  Future<String> createProject(
    String orgId,
    String name,
    String description,
    String depId,     // the department that owns the project
    String createdBy, // uid of the admin / dep head
  ) async {
    final projRef = _projectsRef(orgId).doc(); // auto ID of project

    final project = Project(
      projRef.id,
      name,
      description,
      '',             // summary is empty until the first meeting
      DateTime.now(),
      0,              // progression starts at 0
    );

    //extra fields that are not in the model yet are added next to toMap()
    //projId is saved too because Project.fromMap reads it from the map
    await projRef.set({
      ...project.toMap(),
      'projId': projRef.id,
      'orgId': orgId,
      'depId': depId,
      'createdBy': createdBy,
      'memberIds': <String>[],
    });

    return projRef.id;
  }

  //---------------
  //gets the projects depending on the user role
  //admin -> all org projects , dep head -> his dep projects , employee -> projects he is a member in
  Future<List<Project>> getProjectsForUser(UserModel user) async {
    Query<Map<String, dynamic>> query = _projectsRef(user.orgId);

    switch (user.role) {
      case UserRole.orgAdmin:
        break; // no filter , gets everything
      case UserRole.depHead:
        query = query.where('depId', isEqualTo: user.depId);
        break;
      case UserRole.employee:
        query = query.where('memberIds', arrayContains: user.id);
        break;
    }

    final result = await query.get();

    //converting each doc into a model using the fromMap
    return result.docs
        .map((doc) => Project.fromMap(doc.data(), doc.id))
        .toList();
  }

  //---------------
  //edits the name and description of the project
  Future<void> updateProject(
    String orgId,
    String projId,
    String name,
    String description,
  ) async {
    await _projectsRef(orgId).doc(projId).update({
      'name': name,
      'description': description,
    });
  }

  //---------------
  //firestore does not delete subcollections with the doc ,
  //so meetings and tickets are deleted first then the project
  //a batch so either everything is deleted or nothing is
  Future<void> deleteProject(String orgId, String projId) async {
    final projRef = _projectsRef(orgId).doc(projId);

    final meetings = await projRef.collection('meetings').get();
    final tickets = await projRef.collection('tickets').get();

    final batch = _db.batch();
    for (final doc in meetings.docs) {
      batch.delete(doc.reference);
    }
    for (final doc in tickets.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(projRef);

    await batch.commit();
  }

  //---------------
  //progression = done tickets / all tickets * 100
  Future<void> recalculateProgression(String orgId, String projId) async {
    final projRef = _projectsRef(orgId).doc(projId);
    final tickets = await projRef.collection('tickets').get();

    int progression = 0;
    if (tickets.docs.isNotEmpty) {
      final doneCount =
          tickets.docs.where((doc) => doc.data()['status'] == 'done').length;
      progression = ((doneCount / tickets.docs.length) * 100).round();
    }

    await projRef.update({
      'progression': progression,
    });
  }

  //---------------
  //saves the summary made by the ai after a meeting
  Future<void> updateSummary(
    String orgId,
    String projId,
    String summary,
  ) async {
    await _projectsRef(orgId).doc(projId).update({
      'projectSummary': summary,
    });
  }
}
