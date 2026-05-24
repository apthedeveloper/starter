import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starter_project/features/auth/data/models/user.model.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart'
    as authuser;


class FirebaseAuthImpl implements AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseFirestore.instance.collection("users");
  @override
  Future<bool?> login({
    required String email,
    required String password,
    required bool isSignup,
  }) async {
    if (isSignup) {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }

    return true;
  }

  @override
  Future<bool?> sendVerificationEmail() async {
    await _auth.currentUser?.sendEmailVerification();
    return true;
  }

  @override
  Future<bool?> isEmailVerified() async {
    return _auth.currentUser?.emailVerified;
  }

  @override
  Future<authuser.User?> fetchUserProfile() async {
    final currentUser = await getFirebaseUser();
    if (currentUser == null) {
      return null;
    }
    final userSnapshot = await _user.doc(currentUser.uid).get();
    final model = UserModel.fromSnapshot(
      currentUser.uid,
      currentUser.emailVerified,
      userSnapshot,
    );
    return model.toEntity();
  }

  @override
  Stream<authuser.User?> startListenUserStateChanges() {
    getFirebaseUser();
    return _auth.idTokenChanges().switchMap((firebaseUser) {
      if (firebaseUser == null) {
        return Stream.value(null);
      }
      return _user.doc(firebaseUser.uid).snapshots().map((snapshot) {
        if (!snapshot.exists) {
          return null;
        }

        final model = UserModel.fromSnapshot(
          firebaseUser.uid,
          firebaseUser.emailVerified,
          snapshot,
        );

        return model.toEntity();
      });
    });
  }

  @override
  Future<authuser.User?> completeProfile(
    final Map<String, dynamic> data,
  ) async {
    await _user.doc(_auth.currentUser!.uid).set(data, SetOptions(merge: true));
    return await fetchUserProfile();
  }

  @override
  Future<bool?> forgetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
    return true;
  }

  @override
  Future<User?> getFirebaseUser() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser;
  }

  @override
  Future<bool> logout() async {
    await _auth.signOut();
    return true;
  }

  @override
  Future<bool?> deleteProfile() async {
    await _user.doc(_auth.currentUser!.uid).delete();
    await _auth.currentUser!.delete();
    return true;
  }
}
