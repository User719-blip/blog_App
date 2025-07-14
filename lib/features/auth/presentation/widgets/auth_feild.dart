import 'package:flutter/material.dart';
//
class AuthFeild extends StatelessWidget {
 final String hintText;
 final TextEditingController controller ;
 //to make text obscure for password
 final bool isObscureText ;
const AuthFeild({ 
  super.key , required this.hintText , required this.controller , this.isObscureText = false,
  });
 //taking value from constructor coz hint text is diffrent for email name and password
  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator: (value) 
      {
        if(value!.isEmpty)
        {
          return '$hintText can not be empty';
        }
        return null;
      },
      //provodes proprerty to hind text
      obscureText: isObscureText,
    );
  }
}