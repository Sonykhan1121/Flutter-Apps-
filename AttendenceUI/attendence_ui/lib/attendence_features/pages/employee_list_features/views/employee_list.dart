import 'dart:async';

import 'package:attendence_ui/attendence_features/pages/add_employee_features/views/addemployee.dart';
import 'package:attendence_ui/attendence_features/pages/employee_list_features/views/profilerow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../navigation_page.dart';
import '../provider/employee_provider.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Timer.periodic(Duration(seconds: 5),(timer)  {
    //   print("Timer Periodic :${DateTime.now().second}");
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to login screen
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Employee List",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Consumer<EmployeeProvider>(
                builder: (context, employeeProvider, _) {
                  if(employeeProvider.isLoading)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  if (employeeProvider.profiles.isEmpty) {
                    return  Center(
                      child: Text('No Employees Found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: employeeProvider.profiles.length,
                    itemBuilder: (context, index) {
                      print("found id:${employeeProvider.profiles[index].id}");
                      return ProfileRow(

                        employee: employeeProvider.profiles[index],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Add a new employee
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004368),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Employee",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
