/*
Bloc Pattern:
AuthBloc is a BLoC (Business Logic Component) that manages authentication-related events and states in your app.

Dependency:
It takes a UserSignUp use case as a dependency (injected via the constructor).

Event Handling:
It listens for the AuthSignUp event. When this event is added (for example, when a user submits a sign-up form), it:

Calls the UserSignUp use case with the provided name, email, and password.
Waits for the result (res), which is an Either<Failure, String>.
If there’s a failure, it emits an AuthFailure state with the error message.
If successful, it emits an AuthuSucess state with the success value (e.g., user ID).
*/
import 'package:blog_app/core/comman/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  //why not use this._usersign up here search
  AuthBloc({
    required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
    required UserSignIn userSignIn,
    required UserSignUp userSignUp,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading()); // loding indicator
      final res = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSucess(user, emit),
      );
      //emit AuthSuccess(user);
    });
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading()); // loading indicator
      final res = await _userSignIn(
        UserSignInParams(email: event.email, password: event.password),
      );
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) =>_emitAuthSucess(user, emit),
      );
      //emit AuthSuccess(user);
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      emit(AuthLoading()); // loading indicator
      final res = await _currentUser(NoParams());
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSucess(user, emit),
      );
      //emit AuthSuccess(user);
    });
  }

  void _emitAuthSucess(User user,
    Emitter<AuthState> emit, )
  {
  _appUserCubit.updateUser(user);
  print('AuthuSucess emitted');
  emit(AuthuSucess(user));

  }
}
