import 'package:insync/model/project.dart';
import 'package:insync/model/user.dart';
import 'package:uuid/uuid.dart';

class Ticket {

  Uuid ticketId;
  Project belongingProject;

  Priority priority = .undetermined;

  String title;
  String description;

  DateTime dueDate;
  DateTime lastUpdated;
  DateTime creationDate;

  User assignedTo;
  List<User> assignedBy;

  Ticket(this.ticketId, this.belongingProject, this.priority, this.title,
      this.description, this.dueDate, this.lastUpdated, this.creationDate,
      this.assignedTo, this.assignedBy);

}

enum Priority {

  high,
  medium,
  low,
  undetermined
}