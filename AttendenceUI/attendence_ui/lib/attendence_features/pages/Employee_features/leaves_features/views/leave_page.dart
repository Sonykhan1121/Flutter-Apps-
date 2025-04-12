import 'package:attendence_ui/attendence_features/pages/Employee_features/leave_application_form_features/leave_application_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Colors/colors.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final List<Map<String, dynamic>> leaves = [
    {
      'type': 'Sick leave',
      'status': 'Approved',
      'startDate': "01 apr",
      'endDate': " 03 apr",
    },
    {
      'type': 'Hold design workshops',
      'status': 'Rejected',
      'startDate': "01 apr",
      'endDate': " 03 apr",
    },
    {
      'type': 'Requirements Gathering',
      'status': 'Pending',
      'startDate': "10 apr",
      'endDate': " 17 apr",
    },
    {
      'type': 'Deployment',
      'status': 'Approved',
      'startDate': "15 apr",
      'endDate': " 30 jun",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Leaves'),
          centerTitle: true,
        actions: [
          IconButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplicationForm()));

          }, icon: SvgPicture.asset("assets/icons/leave_application_employee.svg",))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'My Activities',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Cl.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.sp),
              itemCount: leaves.length,
              separatorBuilder:
                  (context, index) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: const Divider(height: 1),
                  ),
              itemBuilder: (context, index) {
                return TaskItem(
                  title: leaves[index]['type'],
                  dateStart: leaves[index]['startDate'],
                  dateEnd: leaves[index]['endDate'],
                  status: leaves[index]['status'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final String dateStart;
  final String dateEnd;
  final String status;

  const TaskItem({
    Key? key,
    required this.title,
    required this.dateStart,
    required this.dateEnd,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Task name
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 5.h),
              Text(
                "${dateStart}-${dateEnd}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),

          Text(
            status,
            style: TextStyle(
              color:
                  status == 'Approved' ? Color(0xFF069855) : Color(0xFFD62525),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
