import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Colors/colors.dart';

class DeviceSettingsPage extends StatelessWidget {
  // Sample device data - in a real app this would come from your device
  final Map<String, String> deviceData = {
    "deviceName": "Face Attendance Terminal FT-7500",
    "macAddress": "00:1B:44:11:3A:B7",
    "ipAddress": "192.168.1.105",
    "firmwareVersion": "v2.3.1",
    "connectionStatus": "Connected",
    "lastSynced": "Today, 10:23 AM",
    "storageAvailable": "3.2 GB",
    "registeredEmployees": "124",
  };

  DeviceSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Settings'),
        centerTitle:  true,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Image (takes 1/3 of screen height)
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/iphone13.jpg', // Replace with your actual image path
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Device Details',
                style: TextStyle(
                  color: Cl.primaryColor,
                  fontSize: 16.sp,
                ),
              ),
            ),

            const Divider(thickness: 1),

            // Device Details List
            _buildDetailItem(context, 'Device Name', deviceData['deviceName']!),
            _buildDetailItem(context, 'MAC Address', deviceData['macAddress']!),
            _buildDetailItem(context, 'Connection Status', deviceData['connectionStatus']!),
            _buildDetailItem(context, 'Last Synced', deviceData['lastSynced']!),
            _buildDetailItem(context, 'Storage Available', deviceData['storageAvailable']!),
            _buildDetailItem(context, 'Registered Employees', deviceData['registeredEmployees']!),

            const SizedBox(height: 16),

            // Additional settings
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Device Settings',
                style: TextStyle(
                  color: Cl.primaryColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Divider(thickness: 1,),

            _buildSettingItem(
                context,
                'Recognition Mode',
                'Face + Fingerprint',
                Icons.face,
                    () => _showSettingOptions(context, 'Recognition Mode', ['Face Only', 'Fingerprint Only', 'Face + Fingerprint', 'Card Only'])
            ),

            _buildSettingItem(
                context,
                'Camera Settings',
                'Configure camera parameters',
                Icons.camera_alt,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage('Camera Settings')))
            ),

            _buildSettingItem(
                context,
                'Connectivity',
                'Bluetooth, Wi-Fi, Ethernet',
                Icons.settings_bluetooth,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage('Connectivity Settings')))
            ),

            _buildSettingItem(
                context,
                'Time Settings',
                'Sync device time',
                Icons.access_time,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage('Time Settings')))
            ),

            _buildSettingItem(
                context,
                'Employee Management',
                'Add, remove, modify employee data',
                Icons.people,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage('Employee Management')))
            ),

            _buildSettingItem(
                context,
                'Data Backup',
                'Backup and restore device data',
                Icons.backup,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyPage('Data Backup')))
            ),

            // Data Transfer Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Data Transfer',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            _buildSettingItem(
                context,
                'Copy Data to Another Device',
                'Transfer data while keeping original copy',
                Icons.copy,
                    () => _showDataTransferDialog(context, 'Copy Data')
            ),

            _buildSettingItem(
                context,
                'Move Data to Another Device',
                'Transfer data and delete from this device',
                Icons.drive_file_move,
                    () => _showDataTransferDialog(context, 'Move Data')
            ),

            const SizedBox(height: 32),

            // Device description
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Reject Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle reject action
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Cl.primaryColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Remove Device',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Cl.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  // Approve Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle approve action
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Cl.primaryColor,
                        side: BorderSide(width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Cl.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Cl.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showSettingOptions(BuildContext context, String title, List<String> options) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(),
              ...options.map((option) => ListTile(
                title: Text(option),
                onTap: () {
                  // Logic to handle option selection
                  Navigator.pop(context);
                },
              )),
            ],
          ),
        );
      },
    );
  }

  void _showDataTransferDialog(BuildContext context, String operation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('$operation to Another Device'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select a destination device:'),
                  const SizedBox(height: 16),
                  _buildDeviceSelection(context),
                  const SizedBox(height: 16),
                  const Text('Select data to transfer:'),
                  CheckboxListTile(
                    title: const Text('Employee Data'),
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  CheckboxListTile(
                    title: const Text('Attendance Records'),
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                  CheckboxListTile(
                    title: const Text('Device Settings'),
                    value: false,
                    onChanged: (bool? value) {},
                  ),
                  CheckboxListTile(
                    title: const Text('Face Recognition Templates'),
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show progress indicator
                    _showTransferProgress(context, operation);
                  },
                  child: Text(operation.toUpperCase()),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDeviceSelection(BuildContext context) {
    // Sample list of nearby devices
    final devices = [
      {'name': 'Face Terminal FT-7500 (Office)', 'id': '001'},
      {'name': 'Face Terminal FT-7500 (Entrance)', 'id': '002'},
      {'name': 'Face Terminal FT-8000 (Meeting Room)', 'id': '003'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: devices[0]['id'],
        isExpanded: true,
        underline: Container(),
        items: devices.map((device) {
          return DropdownMenuItem<String>(
            value: device['id'],
            child: Text(device['name']!),
          );
        }).toList(),
        onChanged: (value) {
          // Handle device selection
        },
      ),
    );
  }

  void _showTransferProgress(BuildContext context, String operation) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$operation in Progress'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LinearProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Transferring data to selected device...'),
              const SizedBox(height: 8),
              const Text('Please do not disconnect devices during transfer.'),
            ],
          ),
        );
      },
    );

    // Simulate progress completion after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close progress dialog
      Navigator.pop(context); // Close transfer dialog

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$operation completed successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}

// Dummy page for navigation examples
class DummyPage extends StatelessWidget {
  final String title;

  const DummyPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('$title configuration page'),
      ),
    );
  }
}