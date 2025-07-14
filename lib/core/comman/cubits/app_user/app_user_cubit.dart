//use to hold or share data across the app helps the services to connect with each other
//such as auth and and blog can get data from here

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:meta/meta.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    print('AppUserCubit.updateUser called with: $user');
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
