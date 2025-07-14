import 'package:blog_app/core/comman/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/show_snack.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_feild.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gardient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignupPage());
  //provided simplified routing for this page to another this route can be used
  //anyware from here like in sign in page
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //inorder to controll text inside the feild we need text controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
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
      appBar: AppBar(), //to show < button
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is AuthFailure)
              {
                showSnackBar(context , state.message);
              }
            },
            builder: (context, state) {
              if(state is AuthLoading){
                return const Loading(size: 50.0, strokeWidth: 5.0);
              }
              return Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    AuthFeild(hintText: 'Name', controller: nameController),
                    const SizedBox(height: 10),
                    AuthFeild(hintText: 'Email', controller: emailController),
                    const SizedBox(height: 10),
                    AuthFeild(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(height: 10),
                    AuthGardientButton(
                      text: 'sign up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            AuthSignUp(
                              name: nameController.text.trim(),
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
                        Navigator.push(context, SignInPage.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Allredy have an account ? ",
                          //can use text style as well but used inbuild title medium
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'sign in',
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
