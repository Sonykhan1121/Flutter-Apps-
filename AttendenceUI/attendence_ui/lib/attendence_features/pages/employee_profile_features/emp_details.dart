import 'dart:io';

import 'package:attendence_ui/attendence_features/pages/employee_qr_features/employee_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../Colors/colors.dart';

class EmpDetails extends StatefulWidget {
  final int employeeIndex;

  const EmpDetails({super.key, required this.employeeIndex});

  @override
  State<EmpDetails> createState() => _EmpDetailsState();
}

class _EmpDetailsState extends State<EmpDetails> {
  Map<String, dynamic>? employeeData;
  File? selectedImageFile;
  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController monthlySalaryController = TextEditingController();
  TextEditingController otherSalaryController = TextEditingController();
  TextEditingController overtimeController = TextEditingController();
  TextEditingController maxOvertimeHourController = TextEditingController();
  TextEditingController selectedShift = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController activeStatusController = TextEditingController();
  TextEditingController _selectedStatus = TextEditingController();
  String payPeriod = '';

  @override
  void initState() {
    super.initState();
    // _loadEmployeeData();
  }

  // Future<void> _loadEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   Map<String, dynamic>? employeeData =
  //   await databaseHelper.getEmployeeById(widget.employeeIndex);
  //
  //   if (employeeData != null) {
  //     setState(() {
  //       this.employeeData = employeeData;
  //
  //       // Initialize text controllers with employee data
  //       nameController.text = employeeData['name'] ?? '';
  //       idController.text = employeeData['employeeId'].toString();
  //
  //       salaryController.text =
  //           ((double.tryParse(employeeData['salary'] ?? '0') ?? 0) +
  //               (double.tryParse(employeeData['otherSalary'] ?? '0') ?? 0))
  //               .toString();
  //
  //       //workingDayController.text = employeeData['hourlyRate'] ?? '';
  //       selectedShift.text = employeeData['shift'] ?? 'Morning';
  //       _selectedStatus.text = employeeData['status'] ?? 'Active';
  //       payPeriod = employeeData['payPeriod'] ?? '';
  //     });
  //   }
  // }
  //
  // Future<void> _saveEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //
  //   if (employeeData != null) {
  //     // Create a new map without the 'id' field
  //     Map<String, dynamic> updatedEmployeeData = {
  //       'name': nameController.text,
  //       'employeeId': idController.text,
  //       // 'salary': salaryController.text,
  //       // 'otherSalary': otherSalaryController.text,
  //       //'hourlyRate': workingDayController.text,
  //       'status': _selectedStatus.text,
  //       //'overtime': overtimeController.text,
  //       'shift': selectedShift.text,
  //     };
  //
  //     try {
  //       await databaseHelper.insertOrUpdateEmployee(
  //           context, updatedEmployeeData);
  //
  //       DSnackBar.successSnackBar(
  //           title: AppLocalizations.of(context)!.employeeDataAddedSuccessfully);
  //
  //       setState(() {
  //         isEditing = false;
  //       });
  //     } catch (e) {
  //       DSnackBar.errorSnackBar(
  //           title: AppLocalizations.of(context)!.failedToSet);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // if (employeeData == null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Employee'),
    //     ),
    //     body: const Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }

    DateTime now = DateTime.now();
    String month = DateFormat(
      'MMMM',
      Localizations.localeOf(context).toString(),
    ).format(now);
    String day = now.day.toString(); // Get day of the month

    String localizedPayPeriod;
    switch (payPeriod) {
      case 'weekly':
        localizedPayPeriod = 'weekly';
        break;
      case 'monthly':
        localizedPayPeriod = 'monthly';
        break;
      default:
        localizedPayPeriod = ''; // Default or handle unknown payPeriod
        break;
    }
    return Scaffold(
      appBar: AppBar(title: Text('Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: AssetImage(
                              'assets/icons/profilepic.png',
                            ),
                            radius: 50.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Mir Sultan',
                          style: TextStyle(
                            color: Cl.primaryColor,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // January 01
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        spacing: 1,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Cl.primaryColor,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.zero,
                                top: Radius.circular(13),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                month,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              day,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Cl.primaryColor,
                                fontSize: 45.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Working Hours
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFccd9e1),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/work-history.svg',
                                    width: 30.sp,
                                    height: 30.sp,
                                  ),
                                ),
                                Text(
                                  "Working Hours",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  '320 Hours',
                                  style: TextStyle(
                                    color: Cl.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),

                            // Over Time
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFccd9e1),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/clock.svg',
                                    width: 30.sp,
                                    height: 30.sp,
                                  ),
                                ),
                                Text(
                                  "Over Time",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  "40 Hours",
                                  style: TextStyle(
                                    color: Cl.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/Vector.svg',
                  width: 25.sp,
                  height: 25.sp,
                ),
                title: "Employee Name",

              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/montly_salary.svg',
                  width: 25.0,
                  height: 25.0,
                ),
                title: "Monthly Salary",

              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/hourly_rate.svg',
                  width: 25.0,
                  height: 25.0,
                ),
                title: "Hourly rate",

              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/overtime_rate.svg',
                ),
                title: "Overtime rate",

              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/max_overtime_hour.svg',
                ),
                title: "Max Overtime hour",

              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: SvgPicture.asset(
                  'assets/icons/employee_profile/active_status.svg',
                  width: 24.0,
                  height: 24.0,
                ),
                title: Text(
                  "Active status",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Active", style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                onTap: ()  {

                },
              ),


              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/shift.svg',
                ),
                title: "Shift",

              ),

              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: SvgPicture.asset(
                  'assets/icons/employee_profile/salary_rules.svg',
                ),
                title: "Salary Rules",

              ),

              Divider(color: Colors.grey.shade200, thickness: 1),
              GestureDetector(
                onLongPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeQrPage(show: true,)));
                },
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeQrPage(show: false,)));

                },
                child: _buildDetailTile(
                  icon: SvgPicture.asset(
                    'assets/icons/employee_profile/employee_qr_code.svg',
                  ),
                  title: "Employee QR Code",
                ),
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Cl.primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 20.sp,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: Text(
                          "PastData",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isEditing) {
                            setState(() {
                              isEditing = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 20.sp,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          side: BorderSide(color: Cl.primaryColor),
                        ),
                        child: Text(
                          isEditing ? "Update" : "Edit",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Cl.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableText({
    required BuildContext context,
    required TextEditingController controller,
    TextEditingController? suffix,
    required bool enabled,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            decoration: const InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            style: TextStyle(
              fontSize: 16,
              color: enabled ? Colors.black : Colors.grey,
            ),
          ),
        ),
        if (suffix != null)
          Expanded(
            child: TextField(
              controller: suffix,
              enabled: enabled,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              style: TextStyle(
                fontSize: 16,
                color: enabled ? Colors.black : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  Widget _buildDetailTile({
    required Widget icon,
    required String title,
     Widget? child,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Fixed width for the icon
          SizedBox(width: 24, child: icon),
          const SizedBox(width: 16),

          Expanded(
            flex: 1,
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),

         if(child!=null) Expanded(flex: 1, child: child),
        ],
      ),
    );
  }
}
