import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insync/model/user.dart';

class InvitationCodeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> generateCode(
    String expiryDate, // will make it timestamp
    String depName,    // from the name i'll get the id
    String role,       // assignee role (employee or head)
    String ownerId,    // the admin id
  ) async {
    // getting admin first for the orgId
    final adminResult = await _db
        .collectionGroup('users')
        .where('id', isEqualTo: ownerId)
        .get();

    if (adminResult.docs.isEmpty) {
      throw Exception("Admin user not found");
    }

    final adminDoc = adminResult.docs.first;
    final admin = UserModel.fromMap(adminDoc.data(), adminDoc.id);

    // get the department by the name to get the id
    final depResult = await _db
        .collectionGroup('departments')
        .where('depName', isEqualTo: depName)
        .get();

    if (depResult.docs.isEmpty) {
      throw Exception("Department not found");
    }

    final depDoc = depResult.docs.first;
    final depId = depDoc.id; 

    // reference the organization subcollection
    final subcollectionRef = _db
        .collection('oragnaization')
        .doc(admin.orgId)
        .collection('inviteCodes');

    // converting string expiryDate to a firestore Timestamp
    DateTime parsedDate = DateTime.parse(expiryDate);
    Timestamp firestoreTimestamp = Timestamp.fromDate(parsedDate);

    // save the invite code document
    final docRef = await subcollectionRef.add({
      'expiryDate': firestoreTimestamp, // Fixed spelling from 'expiryDare'
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': admin.id,
      'depId': depId,
      'role': role,
      'isUsed': false,
    });

    return docRef.id;
  }
}