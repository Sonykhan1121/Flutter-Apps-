import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FaceAttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Face Attendance',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/pias.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Md G R Pias',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('ID: TG0642', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attendance Overview',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004368),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("01 February 2025"),

                        Icon(Icons.chevron_right),
                      ],
                    ),
                    // Add a trailing icon by placing it inside the label as a Row
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Divider(height: 2),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  attendanceCard(
                    'Total Employee',
                    '150',
                    LucideIcons.briefcase,
                  ),
                  attendanceCard(
                    'Present Employee',
                    '130',
                    LucideIcons.armchair,
                  ),
                  attendanceCard('Absent Employee', '15', LucideIcons.settings),
                  attendanceCard('Late Punch', '05', LucideIcons.alarmClock),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Leave Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004368),
                ),
              ),
              SizedBox(height: 20),
              Divider(height: 2),
              SizedBox(height: 15),
              leaveSummary('Sick leave', '10 Person'),
              leaveSummary('Casual leave', '2 Person'),
              leaveSummary('Other leave', '1 Person'),
              leaveSummary('Maternity leave', '1 Person'),
              leaveSummary('Paternity leave', '1 Person'),
            ],
          ),
        ),
      ),
    );
  }

  Widget attendanceCard(String title, String count, IconData icon) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: get_IconColor(icon).withOpacity(0.2),
              ),

              child: Icon(icon, size: 24, color: get_IconColor(icon)),
            ),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.black)),
            SizedBox(height: 5),
            Text(
              count,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Color get_IconColor(IconData icon) {
    switch (icon) {
      case LucideIcons.briefcase:
        return Colors.blue;
      case LucideIcons.armchair:
        return Colors.green;
      case LucideIcons.settings:
        return Colors.purple;
      case LucideIcons.alarmClock:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Widget leaveSummary(String title, String count) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 14, color: Colors.black)),
            Text(
              count,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
