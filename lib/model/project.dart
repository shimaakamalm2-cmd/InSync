import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String name;
  String description;
  String projectSummary;
  DateTime creationDate;
  int progression;
// add departments id 
  Project(this.name, this.description,this.projectSummary,this.creationDate, this.progression);

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      map['name'],
      map['description'],
      map['projectSummary'],
      (map['creationDate'] as Timestamp).toDate(),
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
