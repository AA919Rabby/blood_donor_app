import 'package:blood_app/app/screens/home/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/controllers/screencontroller/selection_controller.dart';
import 'app/screens/home/home_screen.dart';
import 'app/screens/intro/intro_screen.dart';
import 'firebase_options.dart';



void main()async{
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
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
       home: IntroScreen(),
      // home:NotificationScreen(),
    );
  }
}
