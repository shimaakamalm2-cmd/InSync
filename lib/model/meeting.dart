import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting{
  DateTime creationDate;
  String id;
  String transcript;
  String projId;

  Meeting(this.id,this.transcript,this.projId,this.creationDate);

  factory Meeting.fromMap(Map<String, dynamic> map, String id) {
    return Meeting(
      id,
      map['transcript'],
      map['projId'],
      (map['creationDate'] as Timestamp).toDate(),//saved as Firestore Timestamp
    );
  }

  // id is the Firestore document id, not a field
  Map<String, dynamic> toMap() {
    return {
      'transcript': transcript,
      'projId': projId,
      'creationDate': Timestamp.fromDate(creationDate),
    };
  }
}
