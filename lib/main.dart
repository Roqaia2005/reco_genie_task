import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reco_genie_task/features/auth/services/auth_service.dart';
import 'package:reco_genie_task/features/auth/presentation/views/login_view.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/signup_cubit/signup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(AuthService())),
        BlocProvider(create: (context) => SignupCubit(AuthService())),
      ],

      child: MaterialApp(home: LoginView(), debugShowCheckedModeBanner: false),
    );
  }
}
