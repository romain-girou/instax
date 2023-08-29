part of 'my_user_bloc.dart';

abstract class MyUserEvent extends Equatable {
  const MyUserEvent();

  @override
  List<Object> get props => [];
}

class GetMyUser extends MyUserEvent {
	final String myUserId;

	const GetMyUser({required this.myUserId});

	@override
  List<Object> get props => [myUserId];
}