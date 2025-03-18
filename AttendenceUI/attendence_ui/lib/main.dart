import 'package:attendence_ui/attendence_features/pages/add_employee_features/provider/add_employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'attendence_features/pages/daily_attendence_features/provider/daily_attendence_provider.dart';
import 'attendence_features/pages/employee_list_features/provider/employee_provider.dart';
import 'attendence_features/pages/homepage_features/provider/homeprovider.dart';
import 'attendence_features/pages/navigation_page.dart';
import 'attendence_features/providers/user_provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => HomeBarProvider()),
        ChangeNotifierProvider(create: (_) => DailyAttendanceProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => AddEmployeeProvider()),
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
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: NavigationPage(),
        );
      },
    );
  }
}
