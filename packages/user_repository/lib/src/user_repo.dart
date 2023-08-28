import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

abstract class UserRepository {

	Stream<User?> get user;
	
	Future<void> signIn(String email, String password);

	Future<void> logOut();

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> resetPassword(String email);

	// setUserData
	Future<void> setUserData(MyUser user);

	// getMyUser
	Future<MyUser> getMyUser(String myUserId);
}