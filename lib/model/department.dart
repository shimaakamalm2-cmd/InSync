class Department{
  //TODO: hook it up with org and prepare it for firestore + its services 
  String id;
  String name;
  String? headId;//when dep is added the head is still not assigned to it
  //String orgId; //doesn't need to have it since its its parent id 
  
  Department({
    required this.id,
    required this.name,
    required this.headId
    });

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'headId': headId,
    };
  }

  // Create a Department from a Map (for reading from Firestore/JSON)
  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      headId: map['headId'] ?? '',
    );
  }

}