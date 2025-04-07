
import 'package:attendence_ui/attendence_features/pages/employee_profile_features/semi_monthly_pay.dart';
import 'package:attendence_ui/attendence_features/pages/employee_profile_features/weeklypay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'hourlypay.dart';
import 'monthlypay.dart';




class PayPeriod extends StatefulWidget {
  static const routeName = '/payPeriod';
  final int empID;

  const PayPeriod({required this.empID, Key? key}) : super(key: key);

  @override
  State<PayPeriod> createState() => _PayPeriodState();
}

class _PayPeriodState extends State<PayPeriod> {
  int selectedRadioIndex2 = -1;

  @override
  void initState() {
    super.initState();
    // _loadEmployeeData();
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      selectedRadioIndex2 = value!;
    });
  }

  // Future<void> _loadEmployeeData() async {
  //   final DatabaseHelper databaseHelper = DatabaseHelper();
  //   Map<String, dynamic>? employeeData =
  //   await databaseHelper.getEmployeeById(widget.empID);
  //
  //   if (employeeData != null) {
  //     setState(() {
  //       String payPeriod = employeeData['payPeriod'] ?? '';
  //       switch (payPeriod) {
  //         case 'monthly':
  //           selectedRadioIndex2 = 0;
  //           break;
  //         case 'weekly':
  //           selectedRadioIndex2 = 1;
  //           break;
  //         case 'hourly':
  //           selectedRadioIndex2 = 2;
  //           break;
  //         case 'semiMonthly':
  //           selectedRadioIndex2 = 3;
  //           break;
  //         default:
  //           selectedRadioIndex2 = 0;
  //       }
  //     });
  //   }
  // }

  Widget _buildRadioListTile({
    required int value,
    required String title,
    required Widget targetPage,
  }) {
    bool isSelected = selectedRadioIndex2 == value;
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: selectedRadioIndex2,
          onChanged: _handleRadioValueChange,
        ),
        Expanded(
          child: IgnorePointer(
            ignoring: !isSelected && selectedRadioIndex2 != -1,
            child: Opacity(
              opacity: isSelected || selectedRadioIndex2 == -1 ? 1.0 : 0.4,
              child: ListTile(
                title: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: const Icon(Icons.arrow_right_outlined),
                onTap: () {
                  if (isSelected || selectedRadioIndex2 == -1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => targetPage,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Pay period'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: REdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildRadioListTile(
                  value: 0,
                  title: "Monthly",
                  targetPage:
                  MonthlyPay(empID: widget.empID), // Pass empID if needed
                ),
                _buildRadioListTile(
                  value: 1,
                  title: "Weekly",
                  targetPage:
                  WeeklyPay(empID: widget.empID), // Pass empID if needed
                ),
                _buildRadioListTile(
                  value: 2,
                  title: "Hourly",
                  targetPage:
                  HourlyPay(empID: widget.empID), // Pass empID if needed
                ),
                _buildRadioListTile(
                  value: 3,
                  title: "Semi Monthly",
                  targetPage: SemiMonthlyPay(
                      empID: widget.empID), // Pass empID if needed
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
