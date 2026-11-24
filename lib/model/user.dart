class UserModel {
  String id;
  String name;
  String email;
  UserRole role;

  String orgId;
  String? depId;//optional cuz admin does not have a dep

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.orgId,
    this.depId,
  });

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'],
      email: map['email'],
      role: UserRole.values.byName(map['role']),//saved as string
      orgId: map['orgId'],
      depId: map['depId'],
      );
  }
  Map<String,dynamic> toMap(){
    return{
    'name': name,
    'email': email,
    'role': role.name,
    'orgId': orgId,
    'depId': depId,
    };
  }
}


enum UserRole { orgAdmin, depHead, employee }
