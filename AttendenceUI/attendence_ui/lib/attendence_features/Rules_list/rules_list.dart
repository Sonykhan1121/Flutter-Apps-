import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';

class RulesList extends StatefulWidget {
  const RulesList({super.key});

  @override
  State<RulesList> createState() => _RulesListState();
}

class _RulesListState extends State<RulesList> {


  List<String> rules = [
    "Choose employee work type",
    "Choose attendance method for employee",
    "Choose which information's employee can see",
    "Select employee role in the organization",
    "Determine employee shift hours",
    "Specify employee access levels for confidential data",
    "Assign employee to specific projects",
    "Choose preferred communication method",
    "Set employee performance review frequency",
    "Establish employee training requirements",
    "Identify employee eligibility for benefits programs"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.sp),
        itemCount: rules.length,
        separatorBuilder:
            (context, index) => SizedBox(height: 10.h,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
              decoration: BoxDecoration(
                border: Border.all(width: 1.sp,color: Color(0xFFD6E6F0)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TaskListItem(
                title:rules[index],

              ),
            ),
          );
        },
      ),
    );
  }


  Widget TaskListItem({required String title, int? count})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style:  TextStyle(fontSize: 14.sp),
            maxLines: 2,
          ),
        ),
        SizedBox(width: 15.w,),
        Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
      ],
    );
  }
}
