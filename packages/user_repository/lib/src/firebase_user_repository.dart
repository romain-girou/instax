import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'entities/entities.dart';
import 'user_repo.dart';

class FirebaseUserRepository implements UserRepository {
	FirebaseUserRepository({
		FirebaseAuth? firebaseAuth,
	})  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

	final FirebaseAuth _firebaseAuth;
	final usersCollection = FirebaseFirestore.instance.collection('users');

	/// Stream of [MyUser] which will emit the current user when
	/// the authentication state changes.
	///
	/// Emits [MyUser.empty] if the user is not authenticated.
	@override
	Stream<User?> get user {
		return _firebaseAuth.authStateChanges().map((firebaseUser) {
			final user = firebaseUser;
			return user;
		});
	}

	@override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
				email: myUser.email,
				password: password
			);

			myUser = myUser.copyWith(
				id: user.user!.uid
			);

			return myUser;
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

	@override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
			);
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

	@override
	Future<void> setUserData(MyUser user) async {
		try {
			await usersCollection.doc(user.id).set(user.toEntity().toDocument());
		} catch(e) {
			log(e.toString());
			rethrow;
		}
	}

	@override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
				MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch (e) {
			log(e.toString());
      rethrow;
    }
  }

	@override
	 Future<String> uploadPicture(String file, String userId) async {
		try {
		  File imageFile = File(file);
			Reference firebaseStoreRef = FirebaseStorage
				.instance
				.ref()
				.child('$userId/PP/${userId}_lead');
			await firebaseStoreRef.putFile(
        imageFile,
      );
			String url = await firebaseStoreRef.getDownloadURL();
			await usersCollection
				.doc(userId)
				.update({'picture': url});
			return url;
		} catch (e) {
		  log(e.toString());
			rethrow;
		}
	}


}