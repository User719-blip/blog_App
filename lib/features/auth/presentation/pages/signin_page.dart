import 'package:blog_app/core/comman/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/show_snack.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gardient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());

  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //inorder to controll text inside the feild we need text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  /**
  Controllers are useful for reading/updating field values at any time.
  Form + formKey is useful for validation and managing the form as a whole 
  
  form look at decending widgets for text feild 
  which then can be extracted to fromKey inorder to be validated
  but to get actual data we use controllers like
  nameController.text gives you the current value of the name field.**/

  //GlobalKey is of genric type so type <FormState> has to be defined
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    formKey.currentState?.validate();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // TODO: implement listener

              if (state is AuthFailure) {
                //showing error message using showSnackBar
                showSnackBar(context, state.message);
              }
              if (state is AuthuSucess) {
                // Navigate to sign-in page after successful sign-up
                Navigator.pushReplacement(context, SignInPage.route());
              }
              // else if (state is AuthuSucess) {
              //   //if user is successfully signed in then we can navigate to home page
              //   Navigator.pushReplacementNamed(context, '/home');
              // }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                //if state is loading then we can show the loader
                return const Loading(size: 50.0, strokeWidth: 5.0);
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    AuthFeild(hintText: 'Email', controller: emailController),
                    const SizedBox(height: 10),
                    AuthFeild(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 10),
                    AuthGardientButton(
                      text: 'sign in',
                      onPressed: () {
                        //form validation
                        if (formKey.currentState!.validate()) {
                          //if form is valid then we can call the sign in method
                          //we are using context.read<AuthBloc>() to get the instance of AuthBloc
                          //and then we can add the event to it
                          context.read<AuthBloc>().add(
                            AuthSignIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    //used rich text here with text span
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignupPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          //can use text style as well but used inbuild title medium
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'sign up',
                              //used inbuild title medium with color from pallate used titleMedium? coz
                              //copyWith is used to copy the style and change the color
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPallet.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
