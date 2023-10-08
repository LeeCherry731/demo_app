import 'package:demo_app/controllers/ctr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final fullnameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final usernameCtr = TextEditingController();
  final passwordCtr = TextEditingController();

  bool sFullname = false;

  @override
  void initState() {
    super.initState();
    // authCtr.auth
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: StreamBuilder<User?>(
              stream: authCtr.auth.authStateChanges(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "เข้าสู่ระบบสำเร็จ",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            authCtr.auth.currentUser?.photoURL ??
                                "https://media.vanityfair.com/photos/5f8a0436fcee2a89680237c6/1:1/w_1000,h_1000,c_limit/Lisa-Blackpink-MAC-Lede.jpg",
                          ),
                        ),
                      ),
                      const Text(
                        "ข้อมูลส่วนตัว",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: fullnameCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          prefixIcon: SizedBox(
                            width: 40,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("ชื่อ : "),
                              ),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(),
                          hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                          hintText: "Username",
                        ),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 2,
                        color: Color(0xffEFEFEF),
                      ),
                      TextFormField(
                        controller: fullnameCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          prefixIcon: SizedBox(
                            width: 75,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("เบอร์โทร : "),
                              ),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(),
                          hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                          hintText: "08x-xxx-xxx",
                        ),
                      ),

                      // -------------------------------------------------------
                      const SizedBox(height: 30),
                      const Text(
                        "บัญชี",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextFormField(
                        controller: fullnameCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          prefixIcon: SizedBox(
                            width: 90,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("username : "),
                              ),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(),
                          hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                          hintText: "Username",
                        ),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 2,
                        color: Color(0xffEFEFEF),
                      ),
                      TextFormField(
                        controller: fullnameCtr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          prefixIcon: SizedBox(
                            width: 90,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("password : "),
                              ),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(),
                          hintStyle: TextStyle(color: Color(0xFFD5D5D5)),
                          hintText: "08x-xxx-xxx",
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF43AA2D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          fixedSize: const Size.fromWidth(double.maxFinite),
                        ),
                        onPressed: () async {
                          authCtr.logout();
                        },
                        child: const Text(
                          "ล็อกเอ้า",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
