import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insync/model/org/org.dart';
import 'package:insync/model/user.dart';


class OrgService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //this for creating the org and the admin tog
  Future<void> createOrgWithAdmin({
    required String orgName,
    String?logo,
    required String name,
    required String email,
    required String password,
  }) async {
    //a doc ref is an object that points to a specific document in Firestore
    final orgRef = _db.collection('organizations').doc(); // auto ID of org
    //creating a new user first
    final credential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  // get the newly created user
  final userAuth = credential.user;

  if (userAuth == null) {
    throw Exception('User creation failed');
  }
  final userRef = FirebaseFirestore.instance.collection('users').doc(userAuth.uid);

    final org = Org(
      id: orgRef.id,
      name: orgName,
      logo:logo,
      ownerId: userAuth.uid,
    );

    final user = UserModel(
      id: userAuth.uid,
      name: name,
      email: email,
      orgId: orgRef.id,
      role: UserRole.orgAdmin,
    );

    // A batch saves both documents together , either both succeed
    // or neither does so we dont have half saved data
    final batch = _db.batch();
    batch.set(orgRef, org.toMap());
    batch.set(userRef, user.toMap());
    await batch.commit();
  }


}