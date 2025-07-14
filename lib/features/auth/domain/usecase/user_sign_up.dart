//user case represents the single task that the application will perform
//it allows bussness logic to be independent of external concern
//here we are just sign uping the user
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo_interface.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
//implementaion provided in core folder
class UserSignUp implements UseCase<User, UserSignUpParams> {
  /*
  @override
  Future<Either<Failure, dynamic>> call(params) {
    throw UnimplementedError();
  }
 this happens if not genrics are provided there in UseCase class
  */
  final AuthRepo authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

//class created here give the params to the Params in Usecase class
//as cant pass all paramerts directally
class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
