import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insync/model/meeting.dart';

class MeetingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //helper that points to the meetings subcollection of a project
  //organizations/{orgId}/projects/{projId}/meetings
  CollectionReference<Map<String, dynamic>> _meetingsRef(
    String orgId,
    String projId,
  ) {
    return _db
        .collection('organizations')
        .doc(orgId)
        .collection('projects')
        .doc(projId)
        .collection('meetings');
  }

  //---------------
  //saves a new meeting with its transcript , returns the new meeting id
  //the ai uses the meeting id later to link the tickets it makes to this meeting
  Future<String> createMeeting(
    String orgId,
    String projId,
    String transcript,
  ) async {
    final meetingRef = _meetingsRef(orgId, projId).doc(); // auto ID of meeting

    final meeting = Meeting(
      meetingRef.id,
      transcript,
      projId,
      DateTime.now(),
    );

    await meetingRef.set(meeting.toMap());

    return meetingRef.id;
  }

  //---------------
  //gets all the meetings of a project , newest first
  Future<List<Meeting>> getMeetings(String orgId, String projId) async {
    final result = await _meetingsRef(orgId, projId)
        .orderBy('creationDate', descending: true)
        .get();

    //converting each doc into a model using the fromMap
    return result.docs
        .map((doc) => Meeting.fromMap(doc.data(), doc.id))
        .toList();
  }

  //---------------
  //gets one meeting , returns null if it does not exist
  Future<Meeting?> getMeeting(
    String orgId,
    String projId,
    String meetingId,
  ) async {
    final doc = await _meetingsRef(orgId, projId).doc(meetingId).get();

    if (!doc.exists) {
      return null;
    }

    return Meeting.fromMap(doc.data()!, doc.id);
  }
}
