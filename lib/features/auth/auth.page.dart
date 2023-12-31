import 'dart:io';

import 'package:demo_app/controllers/ctr.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum AuthPageState { signIn, register }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthPageState state = AuthPageState.signIn;
  bool showPassword = false;
  bool showPasswordConfirm = false;
  final emailCtr = TextEditingController();
  final passwordCtr = TextEditingController();
  PlatformFile? pickedFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Image.asset(
                        "assets/icons/auth_logo.png",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("สมัครสมาชิก", style: TextStyle(fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                        hintText: "Username",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            !showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFFD5D5D5),
                          ),
                        ),
                        hintStyle: const TextStyle(color: Color(0xFFD5D5D5)),
                        hintText: "Password",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (password) =>
                          password != null && password.length < 6
                              ? "Enter min. 6 characters"
                              : null,
                    ),
                  ),
                  if (state == AuthPageState.register)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            obscureText: showPasswordConfirm,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPasswordConfirm = !showPasswordConfirm;
                                  });
                                },
                                icon: Icon(
                                  !showPasswordConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFFD5D5D5),
                                ),
                              ),
                              hintStyle:
                                  const TextStyle(color: Color(0xFFD5D5D5)),
                              hintText: "Confirm Password",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (password) =>
                                password != null && password.length < 6
                                    ? "Enter min. 6 characters"
                                    : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                              hintText: "ชื่อ - นามสกุล",
                            ),
                          ),
                        ),
                        if (pickedFile != null)
                          Stack(
                            children: [
                              Image.file(File(pickedFile!.path!)),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pickedFile = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 255, 97, 85),
                                    size: 35,
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          InkWell(
                            onTap: () async {
                              final pic = await FilePicker.platform.pickFiles();
                              if (pic == null) return;
                              setState(() {
                                pickedFile = pic.files.first;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              height: 150,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Color(0xFFD5D5D5),
                                    size: 30,
                                  ),
                                  Text(
                                    "อัพโหลดภาพถ่ายประจำตัว",
                                    style: TextStyle(
                                      color: Color(0xFFD5D5D5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF43AA2D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize: const Size.fromWidth(double.maxFinite)),
                      onPressed: () async {
                        if (state == AuthPageState.register) {
                          authCtr.login(
                            email: emailCtr.text.trim(),
                            password: passwordCtr.text.trim(),
                          );
                        } else {
                          if (pickedFile == null) {
                            return;
                          }

                          await authCtr.registor(
                            email: emailCtr.text.trim(),
                            password: passwordCtr.text.trim(),
                            platformFile: pickedFile!,
                          );
                        }
                      },
                      child: Text(
                        state == AuthPageState.signIn
                            ? "เข้าสู่ระบบ"
                            : "สมัครสมาชิก",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state == AuthPageState.signIn
                          ? const Text("คุณยังไม่มีบัญชีผู้ใช้งาน ?")
                          : const Text("คุณมีบัญชีผู้ใช้งานอยู่แล้ว ?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (state == AuthPageState.register) {
                              state = AuthPageState.signIn;
                            } else {
                              state = AuthPageState.register;
                            }
                          });
                        },
                        child: state == AuthPageState.signIn
                            ? const Text(
                                "เข้าสู่ระบบ",
                                style: TextStyle(color: Colors.blue),
                              )
                            : const Text(
                                "สมัครสมาชิก",
                                style: TextStyle(color: Colors.blue),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
