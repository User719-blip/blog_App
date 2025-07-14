
//we use this so that the Server Execptions all over the applications can be handled form here
class ServerExecption implements Exception {
  final String message;

  ServerExecption( this.message);

}