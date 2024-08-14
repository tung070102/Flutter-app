import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define your app's primary color
        primarySwatch: Colors.blue,
        // Set the background color for all pages
        scaffoldBackgroundColor:
            Colors.grey, // Change this to your desired color
        appBarTheme: const AppBarTheme(
          color: Colors.grey, // Change this to your desired color
        ),
      ),
      home: const LoginScreen(),
      // initialRoute: "/",
      // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
    );
  }
}
