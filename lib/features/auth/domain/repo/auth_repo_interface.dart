
//only defines implementation for the repo in data layer
//efine what authentication actions are possible (like sign up and login),
// but not how they are done.
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/comman/entity/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  /*
  using fpdart pkg we will return the data type like what would be the data type be
  if its a failure or sucess the sucess and failure classes are define in core
  Either is a functional programming type (from the dartz package).
  It represents a value that can be either a Failure (error) or 
  a String (success, e.g., user ID or token).
  This makes error handling explicit and type-safe.
  It's a more modern and safer alternative to the traditional try-catch block.
  */
  //not using user model here why coz me are in domain layer we can access the stuff in data 
  //layer so we use the user form entity
  Future<Either<Failure , User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure , User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });


  Future<Either<Failure , User>> currentUser();
}