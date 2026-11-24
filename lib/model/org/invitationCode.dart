import 'package:cloud_firestore/cloud_firestore.dart';//timestamp exists in firestore not dart so has to be imported
import 'package:insync/model/user.dart';
class invitationCode {
  final String code;// document ID used as invitation code 
  final String depId;
  final UserRole role;
  final String createdBy;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool used;

    invitationCode({
    required this.code,
    required this.depId,
    required this.role,
    required this.createdBy,
    required this.createdAt,
    required this.expiresAt,
    this.used = false,
  });

//factory extracts the data in firestore (reads)
  factory invitationCode.fromMap(
    Map<String, dynamic> map,
    String code,
  ) {
    return invitationCode(
      code: code,
      depId: map['depId'],
      role: UserRole.values.byName(map['role']),
      createdBy: map['createdBy'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expiresAt: (map['expiresAt'] as Timestamp).toDate(),
      used: map['used'] ?? false,
    );
  }

// to map basically stores the data to the collection in firestore (writes)
//org id and the code are not stored since they already exist
  Map<String, dynamic> toMap() {
    return {
      'depId': depId,
      'role': role.name,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'used': used,
    };
  }
}
