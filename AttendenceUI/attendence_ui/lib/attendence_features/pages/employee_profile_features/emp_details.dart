import 'dart:io';

import 'package:attendence_ui/attendence_features/pages/employee_profile_features/pay_period.dart';
import 'package:attendence_ui/attendence_features/pages/employee_profile_features/rules.dart';
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
  TextEditingController salaryController = TextEditingController();
  TextEditingController otherSalaryController = TextEditingController();
  TextEditingController overtimeController = TextEditingController();
  TextEditingController selectedShift = TextEditingController();
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
                            color: Colors.black54,
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFccd9e1),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/icons/work-history.svg',
                                    width: 50.0,
                                    height: 50.0,
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
                                  ),
                                ),
                              ],
                            ),

                            // Over Time
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFccd9e1),
                                  ),
                                  child: Image.asset(
                                    'assets/icons/Vector-1.png',
                                    width: 50,
                                    height: 50,
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
                icon: Image.asset(
                  'assets/icons/emp22.png',
                  width: 25.0,
                  height: 25.0,
                ),
                title: "Employee ID",
                child: _buildEditableText(
                  context: context,
                  controller: idController,
                  enabled: false,
                ),
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: Image.asset(
                  'assets/icons/Vector-2.png',
                  width: 25.0,
                  height: 25.0,
                ),
                title: "Mir Sultan",
                child: _buildEditableText(
                  context: context,
                  controller: nameController,
                  enabled: isEditing,
                ),
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: Image.asset('assets/icons/emp3.png'),
                title: "Salary",
                child: _buildEditableText(
                  context: context,
                  controller: salaryController,
                  enabled: false,
                ),
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              _buildDetailTile(
                icon: Image.asset('assets/icons/emp193.png'),
                title: "shift",
                child: Text('dropdown'),
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Image.asset(
                  'assets/icons/Group_189.png',
                  width: 24.0,
                  height: 24.0,
                ),
                title: Text(
                  "Pay Period",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizedPayPeriod,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => PayPeriod(empID: widget.employeeIndex),
                    ),
                  );
                },
              ),
              Divider(color: Colors.grey.shade200, thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Image.asset(
                  'assets/icons/att_new.png',
                  width: 24.0,
                  height: 24.0,
                ),
                title: Text(
                  "Salary Rules",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("list", style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Rules(empID: widget.employeeIndex),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 16,
                          ),
                        ),
                        child: Text(
                          "PastData",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isEditing)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 20,
                            ), // Adjust padding as needed
                          ),
                          child: Text(
                            "Update",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                            // Navigator.of(context).pop(); // Close dialog,
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 16,
                            ), // Adjust padding as needed
                            backgroundColor: Color(0xFFFFFFFF),
                          ),
                          child: Text(
                            "Edit",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF004368),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
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
    required Widget child,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Fixed width for the icon
        SizedBox(width: 24, child: icon),
        const SizedBox(width: 16),

        Expanded(
          flex: 1,
          child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        ),

        Expanded(flex: 1, child: child),
      ],
    );
  }
}
