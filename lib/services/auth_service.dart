import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insync/model/org/invitationCode.dart';

class AuthService {
  final FirebaseAuth _auth =FirebaseAuth.instance; //instance to use auth for its functions
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //this function registers user with email and pass , ready function in firebase
  //---------------

  Future<void> registerWithCode(
    String email,
    String password,
    String name,
    String code,
    //role , orgId , depId is retrieved from code
  ) async //means wait for creds from form
  {
    //------getting the code , then using it to get the depid and orgid---
    final result = await _db.collectionGroup('inviteCodes').where(FieldPath.documentId, isEqualTo: code).limit(1).get();
      if (result.docs.isEmpty) {
        throw Exception('Invalid invitation code');
        }
        final inviteDoc = result.docs.first;
        //converting the doc into model using the fromMap
        final invitation_code = invitationCode.fromMap(inviteDoc.data(),inviteDoc.id,);
        final depId = invitation_code.depId;
        final role = invitation_code.role;
        final orgId=inviteDoc.reference.parent.parent!.id;

    try {
      //---creating the user by auth---

      //user credential is the returned result from createUserWithEmailAndPassword() , contains all info of the auth user
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //user object here is the authinticated user by firebase auth , not our user class
      User? user = credentials.user;

      //----saving to db----
      if (user != null) {
        String uid = user.uid;//made by auth
        await _db.collection('users').doc(uid).set({
          'email': user.email,
          'name': name,
          'depId':depId,
          'orgId' : orgId,
          'role':role.name,
        });

        await inviteDoc.reference.update({
          'isUsed': true,
        });

      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  //Same logic as prevoius but with login
  Future<void> login(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;

      //print(user?.uid);
    } on FirebaseAuthException catch (e) {
       rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
