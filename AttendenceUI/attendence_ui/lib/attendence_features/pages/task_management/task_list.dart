import 'package:attendence_ui/attendence_features/pages/task_management/task_management.dart';
import 'package:attendence_ui/attendence_features/pages/task_management/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (BuildContext context, TaskProvider provider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16.sp),
                  itemCount: provider.tasks.length,
                  separatorBuilder:
                      (context, index) => SizedBox(height: 10.h,),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskManagementScreen(count: provider.tasks[index]['assign_employee_count'])));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.sp,color: Color(0xFFD6E6F0)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TaskListItem(
                          title:provider.tasks[index]['title'],
                          count: provider.tasks[index]['assign_employee_count'],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskManagementScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cl.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.sp),
                    ),
                  ),
                  child: Text(
                    'Assign Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
        },

      ),
    );
  }


  Widget TaskListItem({required String title,required int count})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:  TextStyle(fontSize: 14.sp),
        ),
        Spacer(),
        Text("$count Persons",style: TextStyle(fontSize: 14.sp,color: Cl.primaryColor.withOpacity(0.6)),),
        Icon(
           Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
      ],
    );
  }
}
