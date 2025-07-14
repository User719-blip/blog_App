part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  
  final User user;

  AppUserLoggedIn({required this.user}) {
    print('AppUserLoggedIn state created for user: $user');
  }
  
}


//core cannot depends up on the the other features but converse is truth
//ie the core cannot have dependencies on the other features

