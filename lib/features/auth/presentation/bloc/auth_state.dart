part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthuSucess extends AuthState {
  final User user ;

  AuthuSucess(this.user);
   

}
final class AuthFailure extends AuthState {
  final String message;

AuthFailure(this.message);
}

