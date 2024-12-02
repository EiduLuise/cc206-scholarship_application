import 'package:cc206_scholarship_application/navbar/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDMz2XYXY4Wmfw1jgsrXVnOcjQxryczTCg",
      appId: "1:581733573303:android:67a0821d1b57a14feba332",
      messagingSenderId: "581733573303",
      projectId: "granted-72bc3",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // Initialize route to start with login page
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEEEEEE),
        ),
      ),
    );
  }
}