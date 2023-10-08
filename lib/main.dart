import 'package:demo_app/controllers/ctr.dart';
import 'package:demo_app/features/account/profile.page.dart';
import 'package:demo_app/features/auth/auth.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF707070)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          outlineBorder: BorderSide(color: Colors.blue),
          filled: true,
          fillColor: const Color(0xFFF9F9F9),
        ),
        fontFamily: GoogleFonts.kanit().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authCtr.auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) return ProfilePage();
          return const AuthPage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 165, 204, 103),
              onPressed: () async {
                await authCtr.auth.signOut();
              },
              child: Icon(Icons.plumbing),
            ),
            FloatingActionButton(
              onPressed: () async {
                final result = await authCtr.auth.signInWithEmailAndPassword(
                    email: "test@test.com", password: "123456\$");
                print(result.credential?.accessToken);
              },
              child: Icon(Icons.navigate_next),
            )
          ],
        ),
      ),
    );
  }
}
