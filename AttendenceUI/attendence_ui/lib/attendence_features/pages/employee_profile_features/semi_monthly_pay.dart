import 'package:attendence_ui/attendence_features/pages/employee_profile_features/primarybutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SemiMonthlyPay extends StatefulWidget {
  static const routeName = '/semiMonthlyPay';
  final int empID;
  const SemiMonthlyPay({required this.empID, super.key});

  @override
  State<SemiMonthlyPay> createState() => _SemiMonthlyPayState();
}

class _SemiMonthlyPayState extends State<SemiMonthlyPay> {
  int? selectedOvertimeOption;
  bool isEnterPerDaySalarySelected = false;
  bool isOvertimeSalarySelected = false;

  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController enterOvertime = TextEditingController();
  final TextEditingController enterPerDaySalary = TextEditingController();
  final TextEditingController countTime = TextEditingController();

  String? selectedStartDayRange1;

  @override
  void dispose() {
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
        isEnterPerDaySalarySelected = true;
        isOvertimeSalarySelected = false;
      } else if (value == 1) {
        enterPerDaySalary.text = '';
        isEnterPerDaySalarySelected = false;
        isOvertimeSalarySelected = true;
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
  //       String? fetchedValue = employeeData['hourlyRate'];
  //       selectedStartDayRange1 =
  //       List.generate(17, (index) => (index + 1).toString()).contains(fetchedValue) ? fetchedValue : null;
  //
  //       selectedOvertimeOption = employeeData['isSelectedFixedHourlyRate'] == 'true' ? 1 : 0;
  //       isEnterPerDaySalarySelected = selectedOvertimeOption == 0;
  //       isOvertimeSalarySelected = selectedOvertimeOption == 1;
  //     });
  //   }
  // }

  final ValueNotifier<String?> selectedStartDayRange = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Semi monthly pay"
            ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "basic salary",
                      style: const TextStyle(fontSize: 15),
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
                      border: const OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "select days",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child:DropdownButton<String>(
                    items: List.generate(
                      17,
                          (index) => DropdownMenuItem<String>(
                        value: (index + 1).toString(),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedStartDayRange.value = value!;
                        selectedStartDayRange1 = value;
                      });
                    },
                    value: selectedStartDayRange.value,
                    hint: Text(
                      selectedStartDayRange1 ?? "1",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    // Below this is specific to `dropdown_button2`

                  )
                  ,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "select over time",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: REdgeInsets.all(12.0),
              child: Container(
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
                            width: MediaQuery.of(context).size.width / 2.4,
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
                        ],
                      ),
                      const SizedBox(height: 10),
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
                                Text("overtime day"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: enterOvertime,

                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: "enter overtime rate",
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                              enabled: isOvertimeSalarySelected,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
               "details",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text.rich(
                TextSpan(text: '\n• from here rich'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: PrimaryButton(
            height: 44.sp,
            onPressed: (){},
            tittleText: Text("save")),
      ),
    );
  }

  // Future<void> _saveEmployee() async {
  //   if (basicSalary.text.isEmpty || selectedStartDayRange1 == null) {
  //     DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.fillInAllField);
  //     return;
  //   }
  //
  //   final Map<String, dynamic> newEmployee = {
  //     'employeeId': widget.empID,
  //     'name': '',
  //     'payPeriod': 'semiMonthly',
  //     'salary': basicSalary.text,
  //     'otherSalary': '0',
  //     'leave': '',
  //     'hourlyRate': selectedStartDayRange1,
  //     'overtimeSalary': '',
  //     'overtimeFixed': selectedOvertimeOption == 1 ? enterOvertime.text : '',
  //     'selectedOvertimeOption': selectedOvertimeOption,
  //     'isSelectedFixedHourlyRate': selectedOvertimeOption == 1 ? 'true' : 'false',
  //   };
  //
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   await databaseHelper.insertOrUpdateEmployee(context, newEmployee);
  //
  //   DSnackBar.successSnackBar(title: AppLocalizations.of(context)!.employeeDataAddedSuccessfully);
  //
  //   Navigator.pop(context); // First pop
  //   Navigator.pop(context); // Second pop
  // }
}
