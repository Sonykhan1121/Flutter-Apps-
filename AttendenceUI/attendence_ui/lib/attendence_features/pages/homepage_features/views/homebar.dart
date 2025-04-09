import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Colors/colors.dart';
import '../provider/homeprovider.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // print('height X width : $height $width');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Face Attendance',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<HomeBarProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40.w,
                        backgroundImage: AssetImage(provider.profileImage),
                      ),
                      SizedBox(width: 14.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.userName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            provider.userId,
                            style: TextStyle(
                              fontSize: 12.w,
                              color: Cl.primaryColor.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance Overview',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Cl.primaryColor,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          DateTime? newdate = await datePicker(provider.selectedDate);
                          if(newdate!=null)
                            {
                              provider.updateSelectedDate(newdate);
                            }
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          color: Cl.primaryColor,
                        ),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.formatDate(provider.selectedDate),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Cl.primaryColor.withOpacity(0.6),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 00.5,
                          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),

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
                  SizedBox(height: 20.h),
                  Divider(height: 2.h),
                  SizedBox(height: 20.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.attendanceData.length,
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
                      final data = provider.attendanceData[index];
                      return attendanceCard(
                        data['title'],
                        data['count'],
                        data['icon'],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Leave Summary',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Cl.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Divider(height: 2.h),
                  SizedBox(height: 15.h),
                  ...provider.leaveSummaryData
                      .map(
                        (data) => leaveSummary(data['title']!, data['count']!),
                      )
                      .toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<DateTime?> datePicker(DateTime datetime) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    return newDate;

  }

  Color getIconColor(String title) {
    switch (title) {
      case 'Total Employee':
        return Colors.blue;
      case 'Present Employee':
        return Colors.green;
      case 'Absent Employee':
        return Colors.orange;
      case 'Late Punch':
        return Colors.red;
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
          Text(
            count,
            style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget leaveSummary(String title, String count) {
    return Card(
      color: Colors.white,
      elevation: 1,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 12.sp, color: Colors.black)),
            Text(
              count,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
