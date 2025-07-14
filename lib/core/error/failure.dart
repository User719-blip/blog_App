//this class here deals with the failure of any kind in the app
//define here coz failure can occure any where in the app and we need to handle it
//without repeating class failure for every thing
class Failure {
  final String message;

  Failure([this.message = 'A failure has occured']);
}