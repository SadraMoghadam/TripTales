import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/login.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/tale.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import 'package:trip_tales/src/pages/home.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart';
import 'firebase_options.dart';

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
      navigatorKey: GlobalContextService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(fontFamily: 'WorkSans'),
      routes: {
        '/': (context) => HomePage(),
        '/loginPage': (context) => LoginPage(),
        '/registerPage': (context) => RegisterPage(),
        '/customMenu': (context) => CustomMenu(),
        '/myTalesPage': (context) => MyTalesPage(),
        '/createTalePage': (context) => CreateTalePage(),
        '/talePage': (context) => TalePage(),
        '/favoriteTalesPage': (context) => FavoriteTales([]),
      },
      initialRoute: '/talePage',
    );
  }
}
