import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Colors/colors.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Define tasks with their names and statuses
  final List<Map<String, dynamic>> tasks = [
    {'name': 'Create new campaign', 'status': 'Completed'},
    {'name': 'Hold design workshops', 'status': 'Not Started'},
    {'name': 'Requirements Gathering', 'status': 'Not Started'},
    {'name': 'Deployment', 'status': 'Not Started'},
    {'name': 'Proof of Concept', 'status': 'Not Started'},
  ];

  // Task status options for dropdown
  final List<String> statusOptions = ['Completed', 'In Progress', 'Not Started'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Task List'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Activities',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Cl.primaryColor,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {},
                  icon: SvgPicture.asset(
                    'assets/icons/calender_employee.svg',
                    height: 20.sp,
                  ),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("April 2025", style: TextStyle(fontSize: 12.sp)),
                      Icon(
                        Icons.chevron_right,
                        color: Cl.primaryColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 00.5,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                      vertical: 5.sp,
                    ),
                  ).copyWith(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return TaskItem(
                  taskName: tasks[index]['name'],
                  status: tasks[index]['status'],
                  statusOptions: statusOptions,
                  onStatusChanged: (newStatus) {
                    setState(() {
                      tasks[index]['status'] = newStatus;
                    });
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

class TaskItem extends StatelessWidget {
  final String taskName;
  final String status;
  final List<String> statusOptions;
  final Function(String) onStatusChanged;

  const TaskItem({
    Key? key,
    required this.taskName,
    required this.status,
    required this.statusOptions,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          // Task name
          Expanded(
            child: Text(
              taskName,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),

          // Status dropdown
          Container(
            height: 40.h,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: StatusDropdown(
              currentStatus: status,
              statusOptions: statusOptions,
              onStatusChanged: onStatusChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusDropdown extends StatelessWidget {
  final String currentStatus;
  final List<String> statusOptions;
  final Function(String) onStatusChanged;

  const StatusDropdown({
    Key? key,
    required this.currentStatus,
    required this.statusOptions,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(

        value: currentStatus,
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color: Cl.primaryColor,
        ),
        dropdownColor: Colors.white, // ✅ Sets dropdown background to white

        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),

        borderRadius: BorderRadius.circular(18),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onStatusChanged(newValue);
          }
        },
        items: statusOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                color: value == 'Completed' ? Colors.black : Colors.grey[700],
                fontSize: 14.sp,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}