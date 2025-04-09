import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Colors/colors.dart';

class EmployeeQrPage extends StatefulWidget {
  bool show;
  String? data;
   EmployeeQrPage({required this.show,this.data,super.key});

  @override
  State<EmployeeQrPage> createState() => _EmployeeQrPageState();
}

class _EmployeeQrPageState extends State<EmployeeQrPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          spacing: 60,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Successfully a new employee added & QR code generated.",
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
            // SvgPicture.asset(
            //   "assets/icons/employee_profile/qr-code.svg",
            //   height: 194.sp,
            //   width: 194.sp,
            // ),
            QrImageView(
              data: widget.data ?? "testing..",
              version: QrVersions.auto,
              size: 200.sp,
            ),

            Text(
              "Share this QR code with new employee",
              style: TextStyle(
                fontSize: 16.sp
              ),
            ),
            Spacer()
            ,
            if(widget.show)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cl.primaryColor, // Dark blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
