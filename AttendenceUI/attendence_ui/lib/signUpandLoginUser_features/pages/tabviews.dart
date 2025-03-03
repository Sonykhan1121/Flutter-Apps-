import 'package:flutter/material.dart';


class TabViews extends StatefulWidget {
  @override
  _DailyAttendanceState createState() => _DailyAttendanceState();
}

class _DailyAttendanceState extends State<TabViews> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Present'),
            Tab(text: 'Absent'),
            Tab(text: 'Overtime'),
          ],
        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AttendanceListScreen(status: 'Present'),
          AttendanceListScreen(status: 'Absent'),
          AttendanceListScreen(status: 'Overtime'),
        ],
      ),
    );
  }
}

class AttendanceListScreen extends StatelessWidget {
  final String status;

  AttendanceListScreen({required this.status});

  final List<Map<String, String>> data = [
    {"name": "Devon Lane", "image": "https://via.placeholder.com/150"},
    {"name": "Theresa Webb", "image": "https://via.placeholder.com/150"},
    {"name": "Annette Black", "image": "https://via.placeholder.com/150"},
    {"name": "Eleanor Pena", "image": "https://via.placeholder.com/150"},
    {"name": "Kathryn Murphy", "image": "https://via.placeholder.com/150"},
    {"name": "Cameron Williamson", "image": "https://via.placeholder.com/150"},
    {"name": "Bessie Cooper", "image": "https://via.placeholder.com/150"},
    {"name": "Albert Flores", "image": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data[index]['image']!),
          ),
          title: Text(data[index]['name']!),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            // Define action on tap
            print('Selected ${data[index]['name']}');
          },
        );
      },
    );
  }
}