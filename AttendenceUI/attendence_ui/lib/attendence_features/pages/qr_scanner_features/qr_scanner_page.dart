import 'package:attendence_ui/attendence_features/pages/qr_scanner_features/scanner_overlay_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../Colors/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const QRScannerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Scan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Scan QR code for operate attendance machine',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Scanner view
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(8),
                      child: MobileScanner(
                        controller: controller,

                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                            // Handle scan result
                            final String code = barcodes.first.rawValue ?? '';
                            debugPrint('Barcode found! $code');

                            // Show a snackbar with the scanned value
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(content: Text('Scanned: $code')),
                            // );

                            setState(() {
                              deviceSerialNo = code.toString();
                            });
                          }
                        },
                      ),
                    ),
                  ),

                  // Scanner overlay
                  CustomPaint(
                    size:  Size(280, 280),
                    painter: ScannerOverlayPainter(),
                  ),

                  // Animated scanning line
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        // Use animation value to move the line up and down within the scan area
                        top: 250 + (_animation.value * 120), // Adjusts position based on animation
                        left: 20,
                        right: 20,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color:  Cl.primaryColor.withOpacity(0.4),
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
            ),
          ),
          const SizedBox(height: 60),
          Container(
            margin:  EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
            padding:  EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            decoration: BoxDecoration(
              color: Cl.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Icon(Icons.phone_android, color: Colors.blue.shade800, size: 20),
                SvgPicture.asset("assets/icons/landline.svg",height: 20.sp,color: Cl.primaryColor,),
                const SizedBox(width: 12),
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
                    Flexible(
                      child: Text(
                        deviceSerialNo ?? '',
                        style: TextStyle(
                          color: Cl.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}