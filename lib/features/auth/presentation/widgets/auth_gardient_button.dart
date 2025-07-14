import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class AuthGardientButton extends StatelessWidget {
  const AuthGardientButton({ super.key, required this.text, required this.onPressed });
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context){
    //wanted a gradient buuton but elevated button does not have gradient
    //so i used container with gradient
    //we didnt set a theme for it becuse this is only gradient button in appp
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppPallet.gradient1,
            AppPallet.gradient2,
          ]
        ),
      borderRadius: BorderRadius.circular(12), // Match container radius
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(472, 55),
          backgroundColor: AppPallet.transparentColor, // Make background transparent so that gradient is visible
          shadowColor: AppPallet.transparentColor ,// Remove Shadow,
          
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}