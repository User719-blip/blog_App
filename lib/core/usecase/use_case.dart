//interfaces for the usecases
//each usecases exposes higher level functionality  like here a sign up
import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SucessType, Params> {
  //call function is unque function as it allows us to imnsert params to the diffrnt 
  //use cases like login has 2 params but signup has 3 
  Future<Either<Failure,SucessType>> call(Params params);
  
}

class NoParams {}