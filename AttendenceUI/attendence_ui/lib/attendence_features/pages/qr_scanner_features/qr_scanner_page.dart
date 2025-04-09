import 'package:attendence_ui/attendence_features/pages/qr_scanner_features/scanner_overlay_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../Colors/colors.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> with SingleTickerProviderStateMixin {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  String? deviceSerialNo = 'A14s5sd41114102';

  // Animation controller for the scanning line
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Create a tween animation that goes from -1 to 1
    _animation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Make the animation repeat in reverse when it completes
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size to make the scanner responsive
    final Size screenSize = MediaQuery.of(context).size;
    final double scannerSize = screenSize.width * 0.8; // 80% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Scan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              'Scan QR code for operate attendance machine',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate the maximum square size that fits in the available space
                      final double maxSize = constraints.maxWidth < constraints.maxHeight * 0.8
                          ? constraints.maxWidth
                          : constraints.maxHeight * 0.8;

                      return SizedBox(
                        width: maxSize,
                        height: maxSize,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Scanner view
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: MobileScanner(
                                controller: controller,
                                onDetect: (capture) {
                                  final List<Barcode> barcodes = capture.barcodes;
                                  if (barcodes.isNotEmpty) {
                                    // Handle scan result
                                    final String code = barcodes.first.rawValue ?? '';
                                    debugPrint('Barcode found! $code');
                                    setState(() {
                                      deviceSerialNo = code;
                                    });
                                  }
                                },
                              ),
                            ),

                            // Scanner overlay
                            CustomPaint(
                              size: Size(maxSize*0.9, maxSize*0.9),
                              painter: ScannerOverlayPainter(
                                cornerColor: Colors.green,
                                strokeWidth: 2.5,
                              ),
                            ),

                            // Animated scanning line
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Positioned(
                                  // Use animation value to move the line up and down within the scan area
                                  top: maxSize / 2 + (_animation.value * maxSize / 3),
                                  left: maxSize * 0.05,
                                  right: maxSize * 0.05,
                                  child: Container(
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blue.shade400.withOpacity(0.5),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Cl.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/icons/landline.svg",
                    height: 20.sp,
                    color: Cl.primaryColor,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device Serial No',
                        style: TextStyle(
                          color: Cl.primaryColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        deviceSerialNo ?? '',
                        style: TextStyle(
                          color: Cl.primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}