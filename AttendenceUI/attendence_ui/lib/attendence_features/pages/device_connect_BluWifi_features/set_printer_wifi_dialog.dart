import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Colors/colors.dart';

class SetPrinterWifiDialog extends StatefulWidget {
  const SetPrinterWifiDialog({super.key});

  @override
  State<SetPrinterWifiDialog> createState() => _SetPrinterWifiDialogState();
}

class _SetPrinterWifiDialogState extends State<SetPrinterWifiDialog> {
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedWifi;
  bool _obscurePassword = true;

  final List<String> wifiNames = ['WiFi_1', 'WiFi_2', 'Office_Network'];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              'Set Printer WiFi',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Cl.primaryColor,
              ),
            ),
             SizedBox(height: 20),

            /// WiFi Dropdown
            DropdownButtonFormField<String>(
              iconDisabledColor: Colors.grey.shade300,
              value: _selectedWifi,
              hint:  Text('Wifi Name'),
              items: wifiNames.map((wifi) {
                return DropdownMenuItem(
                  value: wifi,
                  child: Text(wifi),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedWifi = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,

                // contentPadding:  EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              style: TextStyle(
                fontSize: 20.h,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 16),

            /// Password Input
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(_obscurePassword ?'assets/icons/eye_close.svg' : 'assets/icons/eye_open.svg',color: Cl.primaryColor),
                  // icon: Icon(
                  //   _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  //   size: 20,
                  // ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

              ),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w300,
              ),
            ),

            SizedBox(height: 155.h),

            /// Set Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cl.primaryColor,
                  padding:  EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle submit logic
                  Navigator.pop(context);
                },
                child:  Text(
                  'Set',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}