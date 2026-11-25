import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insync/model/department.dart';

class DepService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDep(String name) async {
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) {
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();

    if (!userDoc.exists) {
      return;
    }
    String orgId = userDoc.get('orgId');

    if (orgId.isEmpty) {
      return;
    }
    // reference the organization subcollection

    final subcollectionRef = _db
        .collection('organizations') // Your parent collection
        .doc(orgId) // The parent organization's document ID
        .collection('departments') // The sub-collection name
        .add({'name': name});
  }

  Future<List<Department>> getAllDeps() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    final orgId = userDoc.data()?['orgId'] ?? '';
    if (orgId.isEmpty) return [];

    final depDocs = await FirebaseFirestore.instance
        .collection('organizations')
        .doc(orgId)
        .collection('departments')
        .get();

    return depDocs.docs.map((doc) {
      final data = doc.data();
      return Department(
        id: doc.id,
        name: data['name'] ?? '',
        headId: data['headId'] ?? '',
      );
    }).toList();
  }
}
