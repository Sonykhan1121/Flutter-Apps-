
import 'package:attendence_ui/attendence_features/pages/employee_profile_features/primarybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeeklyPay extends StatefulWidget {
  static const routeName = '/weeklyPay';
  final int empID;
  const WeeklyPay({required this.empID, super.key});

  @override
  State<WeeklyPay> createState() => _WeeklyPayState();
}

class _WeeklyPayState extends State<WeeklyPay> {
  int? selectedOvertimeOption;
  bool isEnterPerDaySalarySelected = false;
  bool isOvertimeSalarySelected = false;

  final TextEditingController inputWeek = TextEditingController();
  final TextEditingController basicSalary = TextEditingController();
  final TextEditingController enterOvertime = TextEditingController();
  final TextEditingController enterPerDaySalary = TextEditingController();

  String selectedWeekdayEnglish = 'Sunday';
  String? selectedWeekdayLocalized;

  @override
  void initState() {
    // _fetchEmployeeData();
    super.initState();
  }

  @override
  void dispose() {
    inputWeek.dispose();
    basicSalary.dispose();
    enterOvertime.dispose();
    enterPerDaySalary.dispose();
    super.dispose();
  }

  // Future<void> _fetchEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   final employeeData = await databaseHelper.getEmployeeById(widget.empID);
  //   if (employeeData != null) {
  //     setState(() {
  //       basicSalary.text = employeeData['salary'] ?? '';
  //       inputWeek.text = employeeData['hourlyRate'] ?? '';
  //       enterPerDaySalary.text = employeeData['overtimeSalary'] ?? '';
  //       enterOvertime.text = employeeData['overtimeFixed'] ?? '';
  //       selectedWeekdayEnglish = employeeData['leave'] != '' ? employeeData['leave'] : 'Sunday';
  //       selectedWeekdayLocalized = _getLocalizedWeekday(selectedWeekdayEnglish);
  //
  //       selectedOvertimeOption = employeeData['isSelectedFixedHourlyRate'] == 'true' ? 1 : 0;
  //       isEnterPerDaySalarySelected = selectedOvertimeOption == 0;
  //       isOvertimeSalarySelected = selectedOvertimeOption == 1;
  //     });
  //   }
  // }

  // String _getLocalizedWeekday(String englishDay) {
  //   final localizations = AppLocalizations.of(context)!;
  //   switch (englishDay) {
  //     case 'Monday':
  //       return localizations.monday;
  //     case 'Tuesday':
  //       return localizations.tuesday;
  //     case 'Wednesday':
  //       return localizations.wednesday;
  //     case 'Thursday':
  //       return localizations.thursday;
  //     case 'Friday':
  //       return localizations.friday;
  //     case 'Saturday':
  //       return localizations.saturday;
  //     case 'Sunday':
  //       return localizations.sunday;
  //     default:
  //       return localizations.sunday;
  //   }
  // }
  //
  // String _getEnglishWeekday(String localizedDay) {
  //   final localizations = AppLocalizations.of(context)!;
  //
  //   // Create a Map for localized day names to English day names
  //   final Map<String, String> localizedToEnglish = {
  //     localizations.monday: 'Monday',
  //     localizations.tuesday: 'Tuesday',
  //     localizations.wednesday: 'Wednesday',
  //     localizations.thursday: 'Thursday',
  //     localizations.friday: 'Friday',
  //     localizations.saturday: 'Saturday',
  //     localizations.sunday: 'Sunday',
  //   };
  //
  //   // Lookup the English day name using the Map
  //   return localizedToEnglish[localizedDay] ?? 'Sunday';
  // }
  //
  // void _handleWeekdayChange(String? newValue) {
  //   if (newValue != null) {
  //     setState(() {
  //       selectedWeekdayLocalized = newValue;
  //       selectedWeekdayLocalized1.value = newValue;
  //       selectedWeekdayEnglish = _getEnglishWeekday(selectedWeekdayLocalized!);
  //     });
  //   }
  // }

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

  final ValueNotifier<String?> selectedWeekdayLocalized1 = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {

    final weekdayNames = [
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
      "saturday",
      "sunday",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Weekly Pay"
            ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "input week",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: inputWeek,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: "enter week",
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
                      labelText: "Enter basic salary",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: const OutlineInputBorder(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "select week start day",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
               "overtimerate",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffb004368)),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
                                Text("overtimeday"),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: enterOvertime,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: "enter overtime rate",
                                border: OutlineInputBorder(),
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
            SizedBox(
              height: 10.h,
            ),
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
                TextSpan(text: '\n• from here 3'),
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
            tittleText: Text("Save")),
      ),
    );
  }

  // Future<void> _saveEmployee() async {
  //   if (basicSalary.text.isEmpty && inputWeek.text.isEmpty) {
  //     DSnackBar.errorSnackBar(title: AppLocalizations.of(context)!.fillInAllField);
  //     return;
  //   }
  //
  //   final Map<String, dynamic> newEmployee = {
  //     'employeeId': widget.empID,
  //     'name': '',
  //     'payPeriod': 'weekly',
  //     'salary': basicSalary.text,
  //     'otherSalary': '0',
  //     'leave': selectedWeekdayEnglish,
  //     'hourlyRate': inputWeek.text,
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
  //   Navigator.of(context).pop(true);
  //   Navigator.of(context).pop(true);
  // }
}
