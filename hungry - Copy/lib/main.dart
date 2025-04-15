import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/views/screens/auth/welcome_page.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'package:hungry/views/widgets/modals/login_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Decide what to show first
  Widget firstPage;
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false); // so next time it's false
    firstPage = WelcomePage(); // first ever launch
  } else if (currentUser != null) {
    firstPage = PageSwitcher(); // already logged in
  } else {
    firstPage = WelcomePage(); // not logged in
  }

  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  final Widget firstPage;
  const MyApp({required this.firstPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: firstPage,
    );
  }
}
