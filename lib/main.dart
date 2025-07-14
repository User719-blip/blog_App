import 'package:blog_app/core/comman/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secret/app_auth_secret.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repo/auth_repo_implementation.dart';
import 'package:blog_app/features/auth/domain/usecase/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/blogs/presentation/pages/blog_page.dart';
import 'package:blog_app/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//supabase.inisilizer gives ontrol over data on supabase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //store in var for furthere use like supabase.database etc
  // final supaBase = await Supabase.initialize(
  //   url: AppAuthSecret.supaBaseURL,
  //   anonKey: AppAuthSecret.anonKey, get it from initdepencecy
  // );
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  //why this function
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            print('isLoggedIn: $isLoggedIn');
            return BlogPage();
          } else {
            print('this block');
            return const BlogPage();
          }
        },
      ),
    );
  }
}
