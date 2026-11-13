import 'package:flutter/material.dart';
import 'package:insync/model/project.dart';
import 'package:insync/model/user.dart';
import 'package:uuid/uuid.dart';

class Ticket {

  Uuid ticketId;
  Project belongingProject;

  Priority priority = Priority.undetermined;

  String title;
  String description;

  DateTime dueDate;
  DateTime lastUpdated;
  DateTime creationDate;

  User assignedBy;
  List<User> assignedTo;

  Ticket(this.ticketId, this.belongingProject, this.priority, this.title,
      this.description, this.dueDate, this.lastUpdated, this.creationDate,
      this.assignedBy, this.assignedTo);

    String get priorityText => priority.priorityText;  

}

enum Priority {

  high,
  medium,
  low,
  undetermined;
  
  //made a getter to return the priority as a string
  String get priorityText {
    switch (this) {
      case Priority.high:
        return 'High';
      case Priority.medium:
        return 'Medium';
      case Priority.low:
        return 'Low';
      case Priority.undetermined:
        return 'Undetermined';
    }
  }
  Color getPriorityColor() {
    switch (this) {
      case high:
        return Colors.red;
      case medium:
        return Colors.yellow;
      case low:
        return Colors.green;
      case undetermined:
        return Colors.grey;
    }
  }
}
