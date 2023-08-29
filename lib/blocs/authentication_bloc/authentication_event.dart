part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
	const AuthenticationEvent();

	@override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User? user;
}