import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String projId;
  String name;
  String description;
  String projectSummary;
  DateTime creationDate;
  int progression;

  Project(this.projId, this.name, this.description,this.projectSummary,this.creationDate, this.progression);

  factory Project.fromMap(Map<String, dynamic> map, String id) {
    return Project(
      map['projId'],
      map['name'],
      map['description'],
      map['projectSummary'],
      (map['creationDate'] as Timestamp).toDate(),//saved as Firestore Timestamp
      map['progression'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'projectSummary': projectSummary,
      'creationDate': Timestamp.fromDate(creationDate),
      'progression': progression,
    };
  }
}
