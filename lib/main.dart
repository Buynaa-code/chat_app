import 'package:chat_app/bloc/login_bloc.dart';
import 'package:chat_app/bloc/login_state.dart';
import 'package:chat_app/screens/loginScreen/login_screen.dart';
import 'package:chat_app/screens/onboarding_screen.dart';

import 'package:chat_app/screens/widget/bottom_navigation.dart'; // Import BottomNavigationDemo
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/', // Starting route is OnboardingScreen
        routes: {
          '/': (context) => const OnboardingScreen(), // Onboarding screen route
          '/login': (context) => const LoginScreen(), // Login screen route
          '/home': (context) =>
              const BottomNavigationDemo(), // Bottom Navigation route
        },
        builder: (context, child) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoggedIn) {
                // Navigate to home screen after successful login
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
            child: child!,
          );
        },
      ),
    );
  }
}
