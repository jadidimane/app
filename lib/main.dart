import "package:app/screens/home.page.dart";
import "package:app/screens/login.page.dart";
import "package:app/screens/register.page.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        kIsWeb ? DefaultFirebaseOptions.web : DefaultFirebaseOptions.android,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 196, 152, 207)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Application de imane',
      //home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
