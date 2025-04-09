import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Colors/colors.dart';

class InputPasswordDialog extends StatefulWidget {
  const InputPasswordDialog({super.key});

  @override
  State<InputPasswordDialog> createState() => _InputPasswordDialogState();
}

class _InputPasswordDialogState extends State<InputPasswordDialog> {
  bool isObscure = true;
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Input Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Cl.primaryColor,
              ),
            ),
            SizedBox(height: 38.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(
                  color: Cl.primaryColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: passwordController,
              obscureText: isObscure,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(



                filled: true,
                fillColor: Color(0xFF9E9B9B),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(isObscure ?'assets/icons/eye_close.svg' : 'assets/icons/eye_open.svg',color:Cl.primaryColor,),
                  // icon: Icon(
                  //   isObscure ? Icons.visibility_off : Icons.visibility,
                  // ),
                  onPressed: () {
                    setState(() => isObscure = !isObscure);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Cl.primaryColor,
              ),
            ),
            SizedBox(height: 128.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cl.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child:  Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize:15.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}