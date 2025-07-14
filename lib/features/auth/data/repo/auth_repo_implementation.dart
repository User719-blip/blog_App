//this file will implement the repo interface of domain

import 'package:blog_app/core/error/execptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:blog_app/features/auth/domain/repo/auth_repo_interface.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';

class AuthRepoImplementation implements AuthRepo {
  
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImplementation(this.remoteDataSource);
  
  
  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final usr = await remoteDataSource.getCurrentUserData();
      if (usr == null) {
      return Left(Failure('No user logged in'));
    }
      //if sucess return right() 
      return Right(usr);
    } on ServerExecption catch (e) {
      //wrap with failure class as fun either want string or failure
      return Left(Failure(e.message));
    }
  }
  //do not do final AuthRemoteDataSourceimpl remoteDataSource;
  //as we do not want dependency on auth_remote_data_source.dart
  //we will pass it as a parameter in constructor of AuthRepoImplementation
  //this is called dependency injection
  /*
  Why use remoteDataSource here?
  The repository is a middleman:
  It calls the data source to do the real work (network call).
  It translates errors from the data source into domain-friendly types.
  It returns results in a way the rest of the app expects (using Either).
  */
  
 
  @override
  //same is signinWithEmailAndPassword
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,

    required String password,
  }) async{
    try{
      print('Calling Supabase signInWithPassword');
      final usr = await remoteDataSource.signinWithEmailAndPassword(
        email: email,
        password: password,
      );
    print('Supabase response: ${usr.email}');

      return Right(usr);
    } 
    
    on ServerExecption catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final usrId = await remoteDataSource.signupWithEmailPasswordAndName(
        name: name,
        email: email,
        password: password,
      );
      //if sucess return right() 
      return Right(usrId);
    } on ServerExecption catch (e) {
      //wrap with failure class as fun either want string or failure
      return Left(Failure(e.message));
    }
  }
}
