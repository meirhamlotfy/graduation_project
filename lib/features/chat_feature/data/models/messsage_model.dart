
class Message{
  final String message;
  final String email;
  final String token;
  Message(this.message, this.email, this.token , );

  factory Message.fromJson(jsonData){
    return Message(jsonData["message"] ,jsonData["userEmail"] ,jsonData["token"] );
  }
}