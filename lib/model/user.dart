import 'package:uuid/uuid.dart';

class User {

  Uuid userId;
  String name;

  User(this.userId, this.name);
  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}