import 'package:attendence_ui/attendence_features/pages/employee_profile_features/primarybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MonthlyPay extends StatefulWidget {
  static const routeName = '/monthlyPay';
  final int empID;
  const MonthlyPay({required this.empID, super.key});

  @override
  State<MonthlyPay> createState() => _MonthlyPayState();
}

class _MonthlyPayState extends State<MonthlyPay> {
  int? selectedOvertimeOption;
  bool isEnterPerDaySalarySelected = false;
  bool isBasicSelected = false;
  bool isOthersSelected = false;
  bool isSelectedFixedHourlyRate = false;
  bool isOvertimeSalarySelected = false;

  int month = DateTime.now().month;
  DateTime selectDate = DateTime.now();

  List<String> monthName = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController othersSalary = TextEditingController();

  final TextEditingController byFixedHourlyRate = TextEditingController();

  final TextEditingController enterPerDaySalary = TextEditingController();
  final TextEditingController enterOvertime = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _fetchEmployeeData();
  }

  // Future<void> _fetchEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   final employeeData = await databaseHelper.getEmployeeById(widget.empID);
  //   if (employeeData != null) {
  //     setState(() {
  //       basicSalary.text = employeeData['salary'] ?? '';
  //       othersSalary.text = employeeData['otherSalary'] ?? '';
  //       byFixedHourlyRate.text = employeeData['hourlyRate'] ?? '';
  //       enterPerDaySalary.text = employeeData['overtimeSalary'] ?? '';
  //       enterOvertime.text = employeeData['overtimeFixed'] ?? '';
  //       selectedOvertimeOption = int.parse(employeeData['selectedOvertimeOption'] ?? '0');
  //       isSelectedFixedHourlyRate = byFixedHourlyRate.text.isNotEmpty;
  //       isBasicSelected = basicSalary.text.isNotEmpty;
  //       isOthersSelected = othersSalary.text.isNotEmpty;
  //     });
  //   }
  // }

  @override
  void dispose() {
    basicSalary.dispose();
    othersSalary.dispose();
    byFixedHourlyRate.dispose();
    enterPerDaySalary.dispose();
    enterOvertime.dispose();
    super.dispose();
  }

  void handleRadioValueChanged(int? value) {
    setState(() {
      selectedOvertimeOption = value;
      countDaySalary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Pay'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isBasicSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            isBasicSelected = value!;
                            countDaySalary();
                          });
                        },
                      ),
                      Text(
                        "Basic Salary",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: TextFormField(
                    controller: basicSalary,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      countDaySalary();
                    },
                    decoration: InputDecoration(
                      labelText: "Enter basic salary",
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isOthersSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            isOthersSelected = value!;
                            countDaySalary();
                          });
                        },
                      ),
                      Text(
                       "other salary",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: TextFormField(
                    controller: othersSalary,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      countDaySalary();
                    },
                    decoration: InputDecoration(
                      labelText: "Enter other salary",
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "Write Working day",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isSelectedFixedHourlyRate,
                        onChanged: (bool? value) {
                          setState(() {
                            isSelectedFixedHourlyRate = value!;
                            countDaySalary();
                          });
                        },
                      ),
                      Text(
                       "Working day",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: TextFormField(
                    controller: byFixedHourlyRate,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      countDaySalary();
                    },
                    decoration: InputDecoration(
                      labelText: "Total working day",
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "Select overtime rate",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                //height: MediaQuery.of(context).size.height/6,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F6F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: 0,
                                  groupValue: selectedOvertimeOption,
                                  onChanged: handleRadioValueChanged,
                                ),
                                Text("Per day salary"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: TextField(
                                    controller: enterPerDaySalary,
                                    decoration: InputDecoration(
                                      labelText: "enter salary",
                                      border: const OutlineInputBorder(),
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: selectedOvertimeOption,
                                  onChanged: handleRadioValueChanged,
                                ),
                                Text("Overtime day"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: TextField(
                                    controller: enterOvertime,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                      labelText: "Enter Overtime",
                                      border: const OutlineInputBorder(
                                      ),

                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                    ),
                                    enabled: selectedOvertimeOption == 1,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "Details",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text.rich(
                TextSpan(text: '\n• from here}'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
            height: 44.sp,
            onPressed: (){},
            tittleText: Text("save"),
      ),
    ),
    );
  }

  // Future<void> _saveEmployee() async {
  //   if (basicSalary.text.isEmpty) {
  //     DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.pleaseFillBasicSalary);
  //     return;
  //   }
  //
  //   Map<String, dynamic> newEmployee = {};
  //
  //   if (selectedOvertimeOption == 1) {
  //     if (enterOvertime.text.isNotEmpty) {
  //       newEmployee = {
  //         'employeeId': widget.empID,
  //         'payPeriod': 'monthly',
  //         'salary': basicSalary.text,
  //         'otherSalary': othersSalary.text,
  //         'hourlyRate': byFixedHourlyRate.text,
  //         'overtimeSalary': enterPerDaySalary.text,
  //         'overtimeFixed': enterOvertime.text,
  //         'selectedOvertimeOption': 1,
  //         'isSelectedFixedHourlyRate': isSelectedFixedHourlyRate.toString(),
  //       };
  //     } else {
  //       DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.selectOvertime);
  //     }
  //   } else {
  //     if (enterPerDaySalary.text.isNotEmpty) {
  //       newEmployee = {
  //         'employeeId': widget.empID,
  //         'name': '',
  //         'payPeriod': 'monthly',
  //         'salary': basicSalary.text,
  //         'otherSalary': othersSalary.text,
  //         'hourlyRate': byFixedHourlyRate.text,
  //         'overtimeSalary': enterPerDaySalary.text,
  //         'overtimeFixed': enterOvertime.text,
  //         'selectedOvertimeOption': 0,
  //         'isSelectedFixedHourlyRate': isSelectedFixedHourlyRate.toString(),
  //       };
  //     } else {
  //       DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.selectOvertime);
  //     }
  //   }
  //
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   await databaseHelper.insertOrUpdateEmployee(context, newEmployee);
  //
  //   DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.employeeDataAddedSuccessfully);
  //
  //   //
  //
  //   Navigator.pop(context); // First pop
  //   Navigator.pop(context); // Second pop
  // }

  void countDaySalary() {
    double countSalary = 0;
    double daySalary = 0;

    if (isSelectedFixedHourlyRate && byFixedHourlyRate.text.isNotEmpty && double.parse(byFixedHourlyRate.text) > 0) {
      if (isBasicSelected &&
          isOthersSelected &&
          double.parse(basicSalary.text) > 0 &&
          double.parse(othersSalary.text) > 0) {
        countSalary = double.parse(basicSalary.text) + double.parse(othersSalary.text);
      } else if (isBasicSelected && basicSalary.text.isNotEmpty && double.parse(basicSalary.text) > 0) {
        countSalary = double.parse(basicSalary.text);
      } else if (isOthersSelected && othersSalary.text.isNotEmpty && double.parse(othersSalary.text) > 0) {
        countSalary = double.parse(othersSalary.text);
      } else {
        countSalary = 0;
      }
      if (countSalary > 0) {
        daySalary = (countSalary / double.parse(byFixedHourlyRate.text));
        enterPerDaySalary.text = daySalary.toStringAsFixed(2).toString();
      } else {
        enterPerDaySalary.text = "0";
      }
    }
  }

  Widget showMonthYearPicker(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: selectDate,
        minimumYear: 2000,
        maximumYear: 2100,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            selectDate = DateTime(newDateTime.year, newDateTime.month);
            month = newDateTime.month;
          });
        },
      ),
    );
  }
}
