import 'package:blog_app/core/comman/entity/user.dart';

//liskoff principal here ? how idk but we are
class UserModel extends User {
  UserModel({ required super.email, required super.password,  required super.name});

//why this line here? serach

factory UserModel.fromJson(Map<String, dynamic> map) {
  return UserModel(
   email : map['email'] ?? ' ',
   password:  map['password'] ?? ' ', // null
    name : map['name'] ?? ' ',
  );
}


  UserModel copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

}

