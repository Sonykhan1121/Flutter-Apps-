import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AttendanceListScreen extends StatelessWidget {
  final String status;

  AttendanceListScreen({super.key, required this.status});

  final List<Map<String, String>> data = [
    {"name": "Devon Lane", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Theresa Webb", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Annette Black", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Eleanor Pena", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Kathryn Murphy", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Cameron Williamson", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Bessie Cooper", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
    {"name": "Albert Flores", "image": "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 29, left: 25, right: 25),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 60.h,  // Set height to 60px
          margin: EdgeInsets.symmetric(vertical: 6),  // Spacing between items
          padding: EdgeInsets.symmetric(horizontal: 12), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.white,  // Background color
            borderRadius: BorderRadius.circular(9),  // Border radius
            border: Border.all(color: Color(0x1A004368)), // 1px solid rgba(0, 67, 104, 0.10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
            crossAxisAlignment: CrossAxisAlignment.center, // Center align vertically
            children: [
              CircleAvatar(
                radius: 25.h,  // Image size 50px (diameter)
                backgroundImage: NetworkImage(data[index]['image']!),
              ),
              SizedBox(width: 10), // Spacing between avatar and text
              Expanded(
                child: Text(
                  data[index]['name']!,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
              Icon(Icons.more_vert, size: 24.w),
            ],
          ),
        );
      },
    );


  }
}