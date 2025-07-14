/*
This file is the “bridge” between your app and the remote authentication 
server (Supabase), handling all the low-level details of network 
communication and error generation.
*/
import 'package:blog_app/core/error/execptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel> signupWithEmailPasswordAndName({
    required String name,
    required String email,
    required String password,
  });

  Future getCurrentUserData() async {
    
  }
}

//this class handels the login and sign up feature with the sever here supabase
/*
The AuthRemoteDataSourceImpl class depends on a SupabaseClient to work.
Instead of creating a SupabaseClient inside the class, it receives it from 
outside (usually from a higher-level part of your app, like a provider or service locator).
*/
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  //after logging up the user we need to create the session comes from supabase
  //sesson gives data for user like email name etc also we need to create a session for user
  //session is used to check the user is logged in or not
  //currentSession is used to get the user details like email name etc
  //we can use currentSession to check the user is logged in or not
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  //this methord actually get you the data for the one user whcih is logged in  you need form the supabase
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null)
        {  final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
          return UserModel.fromJson(userData.first).copyWith(
            email: currentUserSession!.user.email,
          );
        }
        return null ;
      }
    catch (e) {
      return null;
    }
  }

  final SupabaseClient supabaseClient;

  //dependency injection
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw ServerExecption('User not found');
      }
      // Optionally fetch profile data if you store extra info in 'profiles'
      final profileData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', user.id);
      return UserModel.fromJson(profileData.first).copyWith(
        email: user.email ?? '',
      );
    } catch (e) {
      throw ServerExecption('Error Signing in: $e');
    }
  }

  @override
  Future<UserModel> signupWithEmailPasswordAndName({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      //supabaseauth.signUp does not have name type so pass name as data
      //here we are trying to createan user in the supabase
      //respose here is used to check weather user is null or not
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        //creating a custome execption
        throw ServerExecption('User is null');
      }
      //returns user.id defied in the supabase automatically
      //some changes here we are using the user object to get data in json formate ig
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: response.user!.email ?? '',
        name: name, //name is not in the user object so we need to pass it manually
      );
    } catch (e) {
      throw ServerExecption('Error Signing up : $e');
    }
  }
}
