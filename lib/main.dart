import 'package:auy27/provider/search_provider.dart';
import 'package:auy27/screens/academia/academia_screen.dart';
import 'package:auy27/screens/login_screen.dart';
import 'package:auy27/screens/residence/residence_screen.dart';
import 'package:auy27/screens/signup_screen.dart';
import 'package:auy27/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyD5lOtbSFEqnAdxQLZATSYtjyxhS0hkYBs',
          appId: 'mobilesdk_app_id',
          messagingSenderId: 'project_number',
          projectId: 'auy27-bb5c5',
          storageBucket: "auy27-bb5c5.appspot.com"));
  runApp(const MyApp());
  // runApp(MultiProvider(providers: [
  //   ChangeNotifierProvider(create: (_) => SearchProvider()),
  // ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AUY',
      routes: {
        '/': (ctx) => const SplashScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        //  AcademiaScreen.routeName: (ctx) => const AcademiaScreen(category: '',),
        ResidenceScreen.routeName: (ctx) => const ResidenceScreen(
              category: 'Residence',
            ),
      },
      // home: const SplashScreen(),
    );
  }
}
