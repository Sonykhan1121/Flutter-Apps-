import 'package:attendence_ui/attendence_features/pages/employee_profile_features/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HourlyPay extends StatefulWidget {
  static const routeName = '/hourlyPay';
  final int empID;
  const HourlyPay({required this.empID, super.key});

  @override
  State<HourlyPay> createState() => _HourlyPayState();
}

class _HourlyPayState extends State<HourlyPay> {
  int? selectedOvertimeOption;

  bool isEnterPerDaySalarySelected = false;
  bool isOvertimeSalarySelected = false;

  final TextEditingController inputHour = TextEditingController();
  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController enterOvertime = TextEditingController();
  final TextEditingController enterPerDaySalary = TextEditingController();
  final TextEditingController countTime = TextEditingController();

  @override
  void dispose() {
    inputHour.dispose();
    basicSalary.dispose();
    enterOvertime.dispose();
    enterPerDaySalary.dispose();
    countTime.dispose();
    super.dispose();
  }

  void handleRadioValueChanged(int? value) {
    setState(() {
      selectedOvertimeOption = value;
      if (value == 0) {
        enterOvertime.text = '';
      } else if (value == 1) {
        enterPerDaySalary.text = '';
      }
    });
  }

  @override
  void initState() {
    // _fetchEmployeeData();
    super.initState();
  }

  // Future<void> _fetchEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   final employeeData = await databaseHelper.getEmployeeById(widget.empID);
  //   if (employeeData != null) {
  //     setState(() {
  //       basicSalary.text = employeeData['salary'] ?? '';
  //       enterOvertime.text = employeeData['overtimeFixed'] ?? '';
  //       countTime.text = employeeData['hourlyRate'] ?? '';
  //
  //       selectedOvertimeOption = employeeData['isSelectedFixedHourlyRate'] == 'true' ? 1 : 0;
  //       isEnterPerDaySalarySelected = selectedOvertimeOption == 0;
  //       isOvertimeSalarySelected = selectedOvertimeOption == 1;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HourlyPay'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                     "Based Hour",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: inputHour,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: '1',
                      border: OutlineInputBorder(),
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
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                     "hourly salary",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: basicSalary,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "enter basic salary",
                      border: OutlineInputBorder(),
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
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      "Counted Until",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: countTime,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "Counted Until",
                      border: OutlineInputBorder(),
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
              padding: REdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text(
                "details",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: REdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Text.rich(
                TextSpan(text: '\n• "from here"'),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 15),
              child: PrimaryButton(
                  height: 44.h,
                  onPressed: (){},
                  tittleText: Text("Save")),
            )
          ],
        ),
      ),
    );
  }

//   Future<void> _saveEmployee() async {
//     if (basicSalary.text.isEmpty && inputHour.text.isEmpty) {
//       DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.fillInAllField);
//       return;
//     }
//
//     final Map<String, dynamic> newEmployee = {
//       'employeeId': widget.empID,
//       'name': '',
//       'payPeriod': 'hourly',
//       'salary': basicSalary.text,
//       'otherSalary': '0',
//       'hourlyRate': countTime.text,
//       'overtimeSalary': '',
//       'overtimeFixed': '',
//       'selectedOvertimeOption': '',
//       'isSelectedFixedHourlyRate': '',
//     };
//
//     final DatabaseHelper databaseHelper = DatabaseHelper();
//     await databaseHelper.insertOrUpdateEmployee(context, newEmployee);
//
//     DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.employeeDataAddedSuccessfully);
//
//     Navigator.pop(context); // First pop
//     Navigator.pop(context); // Second pop
//   }
}
