import 'package:attendence_ui/attendence_features/pages/add_employee_features/provider/add_employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'attendence_features/pages/daily_attendence_features/provider/daily_attendence_provider.dart';
import 'attendence_features/pages/employee_list_features/provider/employee_provider.dart';
import 'attendence_features/pages/employee_profile_features/emp_details.dart';
import 'attendence_features/pages/homepage_features/provider/homeprovider.dart';
import 'attendence_features/pages/navigation_page.dart';
import 'attendence_features/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Keep the splash screen visible while app is initializing
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  // Your initialization code here (e.g., loading resources, async tasks)
  await Future.delayed(Duration(seconds: 1));  // Simulating some delay

  // Once the initialization is done, remove the splash screen
  FlutterNativeSplash.remove();

  //start the syncing process of local and server
  // PeriodicSyncService.startSyncing();

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
    print('height X weight ${MediaQuery.of(context).size.height} X ${MediaQuery.of(context).size.width}');
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: EmpDetails(employeeIndex: 0,),
        );
      },
    );
  }
}
