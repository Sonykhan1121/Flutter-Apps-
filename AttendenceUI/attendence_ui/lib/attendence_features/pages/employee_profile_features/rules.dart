import 'package:attendence_ui/attendence_features/pages/employee_profile_features/rule_detail.dart';
import 'package:flutter/material.dart';


class Rules extends StatefulWidget {
  static const routeName = '/rules_list';
  final int empID;
  const Rules({required this.empID, Key? key}) : super(key: key);

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  // final DatabaseHelper databaseHelper = DatabaseHelper();
  late List<bool> isChecked;

  String payPeriod = '';

  @override
  void initState() {
    super.initState();
    isChecked = List<bool>.filled(24, false);
    // _loadRuleStatuses();
  }

  // Future<void> _loadRuleStatuses() async {
  //   final result = await databaseHelper.getRule(widget.empID);
  //
  //   if (result != null) {
  //     setState(() {
  //       for (var rule in result) {
  //         int ruleId = int.parse(rule['ruleId']);
  //         isChecked[ruleId] = rule['ruleStatus'] == 1;
  //       }
  //     });
  //   }
  //
  //   final emp = await databaseHelper.getEmployeeById(widget.empID);
  //   setState(() {
  //     payPeriod = emp?['payPeriod'] ?? '';
  //   });
  // }

  // Future<void> _saveRule(int ruleId, bool isChecked) async {
  //   final rule = {
  //     'empId': widget.empID,
  //     'ruleId': ruleId.toString(),
  //     'ruleStatus': isChecked ? 1 : 0,
  //   };
  //
  //   await databaseHelper.insertOrUpdateRule(rule);
  // }

  // void _handleCheckboxChange(int index, bool? value) {
  //   bool canChange = true;
  //   String? message;
  //
  //   // List of indexes for checkboxes 17-21
  //   List<int> checkboxes17to21 = [17, 18, 19, 20, 21];
  //
  //   List<int> checkboxes6to10 = [6, 7, 8, 9];
  //
  //   // Condition: Disable checkboxes 7 to 10 if checkbox 24 is not selected
  //   if (checkboxes6to10.contains(index) && !isChecked[23]) {
  //     canChange = false;
  //     message = AppLocalizations.of(context)!.message4; // Checkbox 23 must be selected before checkboxes 7-10
  //   }
  //
  //   // Ensure isChecked[0] is active for all checkboxes
  //   if (index != 0 && !isChecked[0]) {
  //     canChange = false;
  //     message = AppLocalizations.of(context)!.message1; // Checkbox 1 must be selected for all others
  //   }
  //
  //   // Ensure checkbox 22 is selected before checkbox 11
  //   if (index == 11 && !isChecked[22]) {
  //     canChange = false;
  //     message = AppLocalizations.of(context)!.message3; // Checkbox 23 must be selected before checkbox 12
  //   }
  //
  //   // Condition: Only one of checkboxes 17-21 can be selected at a time
  //   if (checkboxes17to21.contains(index) && value == true) {
  //     for (int i in checkboxes17to21) {
  //       if (i != index && isChecked[i]) {
  //         canChange = false;
  //         message = AppLocalizations.of(context)!.message2; // Only one checkbox from 18-22 can be selected
  //         break;
  //       }
  //     }
  //   }
  //
  //   if (canChange) {
  //     setState(() {
  //       isChecked[index] = value ?? false;
  //     });
  //     _saveRule(index, isChecked[index]);
  //   } else {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(AppLocalizations.of(context)!.notice),
  //           content: Text(message!),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop(); // Close the dialog
  //               },
  //               child: Text(
  //                 AppLocalizations.of(context)!.oK,
  //                 style: TextStyle(color: Theme.of(context).primaryColor),
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Initialize the rules list within the build method

    final rules = [
      'selectWorkShiftTime',
      'selectHoliday',
      'selectWeekend',
      'workOnHolidaysInsteadOfOtherDays',
      'latenessWarningSystem',
      'lateComeGoLater',
      'lateComeCostOverTime',
      'overtimeDoesNotCount',
      'weekendOvertime',
      'holidayOvertime',
      'askForLeave',
      'missedPunchDocument',
      'replacementDay',
      'basicSalaryWithLeaveDeduction',
      'pieceRatePayWithLeaveImpact',
      'lateAttendancePenalty',
      'earlyDepartureDeduction',
      'halfOrFullDayDeduction',
      'hourlyRateForLateness',
      'noTolerancePolicy',
      'incrementalLatenessPenalty',
      'shiftSpecificLatenessDeductions',
      'missedPunch',
      'selectOvertime',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: payPeriod.toLowerCase() == 'hourly' ? 1 : rules.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: isChecked[index],
                    onChanged: (bool? value) {

                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${index + 1}.  ', // Serial number
                                style: const TextStyle(fontWeight: FontWeight.w500), // Bold font for serial number
                              ),
                              TextSpan(
                                text: rules[index], // Rule title
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16.0),
                    ],
                  ),
                  onTap: () {
                    if (isChecked[index]) {

                    } else {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Notice"),
                            content: Text("Select rules to see results"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text(
                                  "oK",
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
