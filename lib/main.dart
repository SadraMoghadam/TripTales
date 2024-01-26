import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trip_tales/src/controllers/auth_controller.dart';
import 'package:trip_tales/src/pages/create_tale_page.dart';
import 'package:trip_tales/src/pages/favorite_tales.dart';
import 'package:trip_tales/src/pages/login.dart';
import 'package:trip_tales/src/pages/profile.dart';
import 'package:trip_tales/src/pages/register.dart';
import 'package:trip_tales/src/pages/my_tales.dart';
import 'package:trip_tales/src/pages/tale.dart';
import 'package:trip_tales/src/services/auth_service.dart';
import 'package:trip_tales/src/services/card_service.dart';
import 'package:trip_tales/src/utils/device_info.dart';
import 'package:trip_tales/src/pages/home.dart';
import 'package:trip_tales/src/widgets/menu_bar_tale.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );//.then((value) => Get.put(AuthenticationRepository));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
        '/profilePage': (context) => ProfilePage(),
      },
      initialRoute: '/talePage',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService(), permanent: true);
        Get.put(AuthController(), permanent: true);
        Get.put(CardService(), permanent: true);
      }),
    );
  }
}
