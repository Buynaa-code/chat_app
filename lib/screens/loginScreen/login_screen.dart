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
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = false;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: successColor4,
            content: Text('Амжилтай нэвтэрлээ!',
                style: ktsBodyMediumBold.copyWith(color: whiteColor))),
      );
      // Navigate to ChatScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );
    } catch (e) {
      // Handle login failure
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.0,
            colors: [Color(0xFF6A95FF), Color(0xFFFFE29F)],
          ),
        ),
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
                    backgroundColor: Colors.white,
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
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                      Text('Тавтай морилно уу!',
                          style: ktsBodyMassivePlusSemiBold.copyWith(
                              color: greyColor8)),
                      const SizedBox(height: 10),
                      Text(
                        'Өөрийн утасны дугаар болон нууц үгээ хийнэ үү',
                        style: ktsBodyMedium.copyWith(color: greyColor4),
                      ),
                      const SizedBox(height: 30),
                      // TextField for the username
                      TextField(
                        controller: _usernameController, // Add controller here
                        cursorColor: informationColor8,
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
                      const SizedBox(height: 10),
                      // TextField for the password
                      TextField(
                        controller: _passwordController, // Add controller here
                        cursorColor: informationColor8,
                        obscureText: _isObscured,
                        decoration: InputDecoration(
                          hintText: 'Нууц үг',
                          hintStyle: ktsBodyMedium.copyWith(color: greyColor4),
                          filled: true,
                          fillColor: greyColor1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          // Add the visibility toggle icon
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
                      // Login button that calls the login function
                      ElevatedButton(
                        onPressed: login, // Use the login function here
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
            ),
          ],
        ),
      ),
    );
  }
}
