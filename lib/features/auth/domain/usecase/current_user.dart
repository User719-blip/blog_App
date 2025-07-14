//checks if user is present or not 

import 'dart:async';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo_interface.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<User, NoParams> {
 
  final AuthRepo authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await  authRepository.currentUser();
  }

}

