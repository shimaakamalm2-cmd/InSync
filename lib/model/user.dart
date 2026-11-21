import 'package:uuid/uuid.dart';

class User {

  Uuid userId;
  String name;
  String orgId;
  String role;

  User(this.userId, this.name,this.orgId,this.role);


  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}