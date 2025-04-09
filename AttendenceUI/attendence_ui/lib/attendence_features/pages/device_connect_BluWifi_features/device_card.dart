import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Colors/colors.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final String mac;
  final bool isConnected;
  final VoidCallback onTap;

  const DeviceCard({
    super.key,
    required this.name,
    required this.mac,
    required this.isConnected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/telephone.svg",height:40.h),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,

                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Mac Address: $mac',
                  style:  TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor:
              Cl.primaryColor.withOpacity(0.05),
              foregroundColor:
              Cl.primaryColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              isConnected ? 'Disconnect' : 'Connect',
              style:  TextStyle(fontSize:15.sp,fontWeight: FontWeight.w600,color: Cl.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}