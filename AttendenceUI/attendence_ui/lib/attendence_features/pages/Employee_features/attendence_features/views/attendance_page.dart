import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Colors/colors.dart';

class AttendancePage extends StatefulWidget {

  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool isHomeSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top bar with back button, user info, and notification bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Icon(Icons.arrow_back_ios, color: Color(0xFF004d71)),
                   Spacer(),
                   // Icon(Icons.notifications_outlined, color: Color(0xFF004d71)),
                  SvgPicture.asset("assets/icons/notification_employee.svg",color:Cl.primaryColor),
                ],
              ),

              const SizedBox(height: 16),

              // User profile section
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Cl.primaryColor,
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/pias.png'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Md G R Pias',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ID: TG0642',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Work type selection
              Container(
                decoration: BoxDecoration(
                color: Cl.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:EdgeInsets.only(left: 10.w,top:8.h),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                       Text(
                        'Select work type',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Cl.primaryColor,
                        ),
                      ),
                       SizedBox(height: 12.h),
                      Divider(height: 1.sp,color: Cl.primaryColor.withOpacity(0.2),),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Home option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isHomeSelected = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric( vertical: 8),

                              child: Row(
                                children: [
                                  Radio(
                                    value: true,
                                    groupValue: isHomeSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        isHomeSelected = true;
                                      });
                                    },
                                    activeColor: const Color(0xFF004d71),
                                  ),
                                  const SizedBox(width: 4),
                                  // const Icon(Icons.home_outlined),
                                  SvgPicture.asset("assets/icons/home_radio_icon.svg",height: 20,),
                                  const SizedBox(width: 4),
                                  const Text('Home'),
                                ],
                              ),
                            ),
                          ),
                           SizedBox(width: 2.w),
                          // Onsite option
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isHomeSelected = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                // border: Border.all(
                                //   color: !isHomeSelected
                                //       ? const Color(0xFF004d71)
                                //       : Colors.grey[300]!,
                                // ),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: false,
                                    groupValue: isHomeSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        isHomeSelected = false;
                                      });
                                    },
                                    activeColor: const Color(0xFF004d71),
                                  ),
                                  const SizedBox(width: 4),
                                  SvgPicture.asset("assets/icons/office.svg",height: 20,),
                                  const SizedBox(width: 4),
                                  const Text('Onsite'),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Time display
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '08 : 00 : 00 am',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF004d71),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '16 April 2025, Thursday',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Check In button
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/icons/touchpad.svg",height: 20,),
                    label: const Text(
                      'Check In',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004d71),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  // Face attendance button
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/icons/face_id.svg",height: 20,),,
                    label: const Text(
                      'Face attendance',
                      style: TextStyle(color: Color(0xFF004d71)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF004d71)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Bottom tabs (without actual navigation)

            ],
          ),
        ),
      ),
    );
  }
}


