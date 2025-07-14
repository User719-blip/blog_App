//holdes dependency for the main functoion
// created to remove the clutter from the main function
//future<void> why?
import 'package:blog_app/core/comman/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secret/app_auth_secret.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repo/auth_repo_implementation.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo_interface.dart';
import 'package:blog_app/features/auth/domain/usecase/current_user.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  final supaBase = await Supabase.initialize(
    url: AppAuthSecret.supaBaseURL,
    anonKey: AppAuthSecret.anonKey,
  );
  //why we use registerLazySingleton? what is significance ?  why this line
  serviceLocator.registerLazySingleton(() => supaBase.client);
  //resgister the depencedy with getit
  _initAuth();
}

void _initAuth() {
  //registerFactory cox we need new insatce of the class supabase
  //also we passed authremotedatasource coz
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepoImplementation(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));

  serviceLocator.registerFactory(
    () => CurrentUser(authRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(), 
      appUserCubit: serviceLocator<AppUserCubit>(),
    ),
  );
  //why should we resgister the calss 1st
}
