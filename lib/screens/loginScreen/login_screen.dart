import 'package:chat_app/service/login/repository/auth_repository.dart';
import 'package:chat_app/const/colors.dart';
import 'package:chat_app/const/spacing.dart';
import 'package:chat_app/const/text_field.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/loginScreen/register_screen.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  final AuthRepository _authRepository =
      AuthRepository(); // Create instance of AuthRepository

  Future<void> login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Утасны дугаар болон нууц үгээ оруулна уу ')),
      );
      return;
    }

    try {
      // Call login method from AuthRepository
      final loginResponse = await _authRepository.login(username, password);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: successColor4,
            content: Text('Амжилтай нэвтэрлээ!',
                style: ktsBodyMediumBold.copyWith(color: whiteColor))),
      );
      // Navigate to ChatScreen after successful login
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: dangerColor5,
            content: Text(
              'Та нууц үг болон утасны дугаараа шалгана уу!',
              style: ktsBodyMediumBold.copyWith(color: whiteColor),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [Color(0xFF6A95FF), Color(0xFFFFE29F)],
          ),
        ),
        child: SingleChildScrollView(
          // Wrap Column with SingleChildScrollView
          child: Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios, color: greyColor5),
                        const SizedBox(width: 4),
                        Text(
                          'Буцах',
                          style: ktsBodyMediumBold.copyWith(color: greyColor5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              h48(),
              h48(),
              h48(),
              h48(),
              h48(),
              h48(),
              Container(
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Нэвтрэх',
                          style: ktsBodyMassivePlusSemiBold.copyWith(
                              color: greyColor8)),
                      h8(),
                      Text('Өөрийн мэдээллээ оруулна уу',
                          style: ktsBodyMedium.copyWith(color: greyColor4)),
                      const SizedBox(height: 20),
                      // Username TextField
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Утасны дугаар',
                          hintStyle: ktsBodyMedium.copyWith(color: greyColor4),
                          filled: true,
                          fillColor: greyColor1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      h8(),
                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Нууц үг',
                          hintStyle: ktsBodyMedium.copyWith(color: greyColor4),
                          filled: true,
                          fillColor: greyColor1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            color: greyColor5,
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured; // Toggle the state
                              });
                            },
                          ),
                        ),
                      ),

                      h48(),
                      // Register Button
                      ElevatedButton(
                        onPressed: login, // Trigger registration
                        style: ElevatedButton.styleFrom(
                          backgroundColor: informationColor8,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 165, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Нэвтрэх',
                          style: ktsBodyLargeBold.copyWith(color: whiteColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Бүртгэл үүсгэх?',
                          style: ktsBodyMediumBold.copyWith(
                              color: informationColor8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
