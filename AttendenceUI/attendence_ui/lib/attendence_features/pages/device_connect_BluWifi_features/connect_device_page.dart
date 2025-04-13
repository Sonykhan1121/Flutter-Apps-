import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Colors/colors.dart';
import '../device_searching_features/device_search_screen.dart';

class ConnectDevicePage extends StatefulWidget {

  const ConnectDevicePage({super.key});

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
  bool _isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
    _requestBluetoothPermission();

    // Listen for Bluetooth state changes
    FlutterBluePlus.adapterState.listen((state) {
      setState(() {
        _isBluetoothOn = state == BluetoothAdapterState.on;
      });
    });
  }

  Future<void> _checkBluetoothStatus() async {
    final state = await FlutterBluePlus.adapterState.first;
    setState(() {
      _isBluetoothOn = state == BluetoothAdapterState.on;
    });
  }

  Future<void> _requestBluetoothPermission() async {
    final permissions = [
       Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
    ];


    // Request permissions
    final statuses = await permissions.request();
    print('map: $statuses');

    // Check if all permissions are granted
    final allGranted = statuses.values.every((status) => status.isGranted);

    if (allGranted) {
      // Try turning Bluetooth on
      if (!_isBluetoothOn) {
        try {
          await FlutterBluePlus.turnOn();
        } catch (e) {
          debugPrint('Bluetooth turn on failed: $e');
          _showBluetoothSettingsDialog();
        }
      }
    } else {
      _showPermissionDeniedDialog();
    }
  }


  void _showBluetoothSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Bluetooth is Off'),
            content: Text(
                'Please enable Bluetooth in your device settings to continue.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Open app settings instead of Bluetooth settings directly
                  openAppSettings();
                },
                child: Text('Open Settings'),
              ),
            ],
          ),
    );
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Permissions Required'),
            content: const Text(
                'Bluetooth and location permissions are required to scan for devices.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg", height: 20.h),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Connect Device',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _connectionTile(
              iconAsset: "assets/icons/bluetooth.svg",
              label: 'Connect Bluetooth',
              onTap: () {


                if (_isBluetoothOn) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeviceSearchScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(

                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 15.w),
                      content: Text(
                        'Please enable Bluetooth first using the floating button',
                        style: TextStyle(color: Colors.white),),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
            // const SizedBox(height: 12),
            // _connectionTile(
            //   iconAsset: "assets/icons/wifi.svg",
            //   label: 'Connect Wi-Fi',
            //   onTap: () {
            //     showDialog(
            //       context: context,
            //       builder: (_) =>  SetPrinterWifiDialog(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _connectionTile({
    required String iconAsset,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Icon(icon, size: 22, color: Colors.black),
          SvgPicture.asset(iconAsset, height: 24.sp,),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Cl.primaryColor,
              backgroundColor: Cl.primaryColor.withOpacity(0.05),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 7.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            onPressed: onTap,
            child: Text(
              'Connect',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}


