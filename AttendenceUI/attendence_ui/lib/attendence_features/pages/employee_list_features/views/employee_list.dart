import 'package:attendence_ui/attendence_features/pages/employee_list_features/views/profilerow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../navigation_page.dart';
import '../provider/employee_provider.dart';

class EmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to login screen
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
                  return ListView.builder(
                    itemCount: employeeProvider.profiles.length,
                    itemBuilder: (context, index) {
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
                    final navPage =
                    context.findAncestorStateOfType<NavigationPageState>();
                    if (navPage != null) {
                      navPage.onTabTapped(2); // Index of "Add Employee" tab
                    }
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
