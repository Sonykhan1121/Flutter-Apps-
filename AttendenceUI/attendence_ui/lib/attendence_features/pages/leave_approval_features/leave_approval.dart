import 'package:attendence_ui/attendence_features/pages/Employee_features/leave_application_form_features/leave_application_form.dart';
import 'package:attendence_ui/attendence_features/pages/Employee_features/leaves_features/views/leave_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../task_management/task_management.dart';

class LeaveApproval extends StatefulWidget {
  const LeaveApproval({super.key});

  @override
  State<LeaveApproval> createState() => _LeaveApprovalState();
}

class _LeaveApprovalState extends State<LeaveApproval> {
  List<TestEmployee> allEmployees = [
    TestEmployee(
      name: 'Devon Lane',
      id: '001',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',


    ),
    TestEmployee(
      name: 'Jane Doe',
      id: '002',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    TestEmployee(
      name: 'John Smith',
      id: '003',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    TestEmployee(
      name: 'Alice',
      id: '004',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
    ),
    TestEmployee(
      name: 'Bob',
      id: '005',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Leave Approval'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w),
        child: ListView.builder(
          itemCount: allEmployees.length,
          itemBuilder: (context, index) {
            final GlobalKey _key = GlobalKey();
            return Container(
              height: 60.h,
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Color(0x1A004368)),
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplicationForm(description: "testing description from list")));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.h,
                      backgroundImage: NetworkImage(allEmployees[index].avatarUrl),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        allEmployees[index].name,
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
