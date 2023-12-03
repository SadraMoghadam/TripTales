import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trip_tales/src/pages/login.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'firebase_options.dart';
import 'src/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(fontFamily: 'Nunito'),
      routes: {
        '/': (context) => HomePage(),
        '/loginPage': (context) => LoginPage(),
        '/registerPage': (context) => RegisterPage(),
      },
      initialRoute: '/',
    );
  }
}

