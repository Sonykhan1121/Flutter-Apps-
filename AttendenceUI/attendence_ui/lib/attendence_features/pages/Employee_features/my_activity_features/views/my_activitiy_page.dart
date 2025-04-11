import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Colors/colors.dart';

class MyActivityPage extends StatefulWidget {
  const MyActivityPage({super.key});

  @override
  State<MyActivityPage> createState() => _MyActivityPageState();
}

class _MyActivityPageState extends State<MyActivityPage> {
  final List<Map<String, dynamic>> attendanceData = [
    {
      'title': 'Absent',
      'count': '0',
      'icon': "assets/icons/absent_employee.svg",
    },
    {
      'title': 'Late in',
      'count': '0',
      'icon': "assets/icons/late_in_employee.svg",
    },
    {
      'title': 'Leaves',
      'count': '2',
      'icon': "assets/icons/leaves_employee.svg",
    },
    {
      'title': 'Overtime',
      'count': '05',
      'icon': "assets/icons/overtimes_employe.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0A4E7C)),
          onPressed: () {},
        ),
        title: const Text(
          'My Activities',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/notification_employee.svg',
              height: 20.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                          // Set the border radius here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Divider(height: 2.h),
              SizedBox(height: 20.h),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: attendanceData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio:
                  width < 430
                      ? 1.0
                      : (width < 801)
                      ? 1.1
                      : 1.3,
                ),
                itemBuilder: (context, index) {
                  final data = attendanceData[index];
                  return attendanceCard(
                    data['title'],
                    data['count'],
                    data['icon'],
                  );
                },
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly attendance',
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
                        Text("01-07 April", style: TextStyle(fontSize: 12.sp)),
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
                          // Set the border radius here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:10.h),
              Divider(height: 2.h,),
              SizedBox(height:20.h),

              _buildAttendanceList(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color getIconColor(String title) {
    switch (title) {
      case 'Absent':
        return Color(0x1A44AEF9);
      case 'Late in':
        return Color(0x1A534FEB);
      case 'Leaves':
        return Color(0x1A534FEB);
      case 'Overtime':
        return Color(0x1AFF9500);
      default:
        return Colors.black;
    }
  }

  Widget attendanceCard(String title, String count, String svgAssets) {
    Color color = getIconColor(title);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color.withOpacity(0.1),
            ),
            child: SvgPicture.asset(svgAssets, height: 20.sp),
          ),
          SizedBox(height: 16.h),
          Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.black)),
          SizedBox(height: 4.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.w), // spacing between number and label
              Text(
                (title == 'Overtime') ? 'hours' : 'Days',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }







  Widget _buildAttendanceList() {
    final List<Map<String, dynamic>> attendanceData = [
      {
        'day': '01',
        'weekday': 'Tue',
        'checkIn': '08:00am',
        'lunchStart': '12:30pm',
        'lunchEnd': '01:30pm',
        'checkOut': '05:00pm',
      },
      {
        'day': '02',
        'weekday': 'Wed',
        'checkIn': '08:00am',
        'lunchStart': '12:30pm',
        'lunchEnd': '01:30pm',
        'checkOut': '05:00pm',
      },
      {
        'day': '03',
        'weekday': 'Thu',
        'checkIn': '08:00am',
        'lunchStart': '12:30pm',
        'lunchEnd': '01:30pm',
        'checkOut': '05:00pm',
      },
      {
        'day': '04',
        'weekday': 'Fri',
        'checkIn': '08:00am',
        'lunchStart': '12:30pm',
        'lunchEnd': '01:30pm',
        'checkOut': '05:00pm',
      },
      {
        'day': '05',
        'weekday': 'Sat',
        'checkIn': '08:15am',
        'lunchStart': '12:15pm',
        'lunchEnd': '01:15pm',
        'checkOut': '04:45pm',
      },
      {
        'day': '06',
        'weekday': 'Sun',
        'checkIn': 'Off',
        'lunchStart': '-',
        'lunchEnd': '-',
        'checkOut': 'Off',
      },
      {
        'day': '07',
        'weekday': 'Mon',
        'checkIn': '08:05am',
        'lunchStart': '12:25pm',
        'lunchEnd': '01:25pm',
        'checkOut': '05:10pm',
      },
    ];


    return Column(
      children:
      attendanceData.map((data) => _buildAttendanceItem(data)).toList(),
    );
  }

  Widget _buildAttendanceItem(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 60.h,

      decoration: BoxDecoration(
        color: Cl.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 60.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: const Color(0xFF0A4E7C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data['day'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  data['weekday'],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeColumn('08:00am', 'Check In', Colors.blue.shade100),
                _buildTimeColumn(
                  '12:30pm',
                  'Lunch Start',
                  Colors.blue.shade100,
                ),
                _buildTimeColumn('01:30pm', 'Lunch End', Colors.blue.shade100),
                _buildTimeColumn('05:00pm', 'Check Out', Colors.blue.shade100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String time, String label, Color bgColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
        ),
      ],
    );
  }
}
