import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruso_chat/screens/mainChatScreen.dart';
import 'package:ruso_chat/screens/login_screen.dart';
import 'package:ruso_chat/screens/registration_screen.dart';
import 'package:ruso_chat/screens/spashScreen.dart';
import 'package:ruso_chat/screens/splashScreen2.dart';
import 'package:ruso_chat/screens/userProfile.dart';
import 'package:ruso_chat/screens/weatherScreen.dart';
import 'package:ruso_chat/screens/welcome_screen.dart';

import 'screens/userProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBmxcSUZ7g6mGAxvkHoct9fJXZdQ1c6P8w",
      appId: "1:669237237204:android:56f7b007c50ee4574e3241",
      messagingSenderId: "",
      projectId: "ruso-chat",
    ),
  );
  runApp(const Ruso());
}

class Ruso extends StatelessWidget {
  const Ruso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        Splash2.id: (context) => const Splash2(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
        USerProfileScreen.id: (context) => const USerProfileScreen(),
        WeatherScreen.id: ((context) => const WeatherScreen()),
      },
    );
  }
}

//flutter.compileSdkVersion
