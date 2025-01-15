import 'dart:convert';
import 'package:chat_app/const/colors.dart';
import 'package:chat_app/const/spacing.dart';
import 'package:chat_app/const/text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool _isObscured = true;
  bool isObscured = true;

  // Register function to handle the registration request
  Future<void> register() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String passwordConfirm = _passwordConfirmController.text.trim();
    // Оруулах утгуудыг шалгах
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Бүх талбарыг бөглөнө үү')),
      );
      return;
    }

    try {
      const url = 'http://localhost:5001/register';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        }),
      );

      // Бүртгэл амжилттай болсон эсэхийг шалгах
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Хэрэглэгч амжилттай бүртгэгдлээ!')),
        );
        // Өмнөх дэлгэц рүү буцах
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else if (response.statusCode == 409) {
        // Хэрэглэгч аль хэдийн бүртгэгдсэн
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Хэрэглэгч аль хэдийн бүртгэгдсэн!')),
        );
      } else {
        // Бусад алдаа
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Бүртгэл амжилтгүй боллоо. Дахин оролдоно уу!')),
        );
      }
    } catch (e) {
      // Сүлжээний алдаа
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Алдаа: $e')),
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
                      Text('Бүртгүүлэх',
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
                      h8(),
                      // Password TextField
                      TextField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Нууц үгээ давтана уу',
                          hintStyle: ktsBodyMedium.copyWith(color: greyColor4),
                          filled: true,
                          fillColor: greyColor1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            color: greyColor5,
                            onPressed: () {
                              setState(() {
                                isObscured = !isObscured; // Toggle the state
                              });
                            },
                          ),
                        ),
                      ),

                      h48(),
                      // Register Button
                      ElevatedButton(
                        onPressed: register, // Trigger registration
                        style: ElevatedButton.styleFrom(
                          backgroundColor: informationColor8,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 150, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Бүртгүүлэх',
                          style: ktsBodyLargeBold.copyWith(color: whiteColor),
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
