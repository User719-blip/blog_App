import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo_interface.dart';
import 'package:fpdart/fpdart.dart';


class UserSignIn implements UseCase<User, UserSignInParams>{
  final AuthRepo authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}