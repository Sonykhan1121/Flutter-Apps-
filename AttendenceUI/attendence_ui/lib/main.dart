import 'package:attendence_ui/signUpandLoginUser_features/pages/navigation_page.dart';
import 'package:attendence_ui/signUpandLoginUser_features/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=>UserProvider()),
    ],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  NavigationPage(),
    );
  }
}
