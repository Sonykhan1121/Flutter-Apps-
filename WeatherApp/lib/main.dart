import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/current_weather_provider.dart';
import 'package:weather_app/providers/themeprovider.dart';
import 'package:weather_app/signUpandLoginUser_features/pages/login_page.dart';
import 'package:weather_app/signUpandLoginUser_features/pages/singup_page.dart';
import 'package:weather_app/signUpandLoginUser_features/pages/verifyaccountpage.dart';
import 'package:weather_app/signUpandLoginUser_features/providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentWeatherProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: value.themeData,
          home:  LoginPage(), // Set HomeScreen as the home
        );
      },),
    );
  }
}
