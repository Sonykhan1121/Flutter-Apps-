import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/daily_attendence_provider.dart';

class AttendanceListScreen extends StatefulWidget {
  final String status;

  const AttendanceListScreen({super.key, required this.status});

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  @override
  Widget build(BuildContext context) {


    return Consumer<DailyAttendanceProvider>(
      builder: (context, attendanceProvider, child) {
        final List<Map<String, String>> data = attendanceProvider.getAttendanceByStatus(widget.status);

        return ListView.builder(
          padding: EdgeInsets.only(top: 29, left: 25, right: 25),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final GlobalKey _key = GlobalKey();
            return Container(
              height: 60.h,
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Color(0x1A004368)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25.h,
                    backgroundImage: NetworkImage(data[index]['image']!),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      data[index]['name']!,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                  ),
                  GestureDetector(
                    key: _key,
                    onTap: (){
                      _showPopupMenu(context, _key);
                    },
                      child: Icon(Icons.more_vert, size: 24.w)
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  void _showPopupMenu(BuildContext context, GlobalKey key) async {
    final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero); // Get the position of the widget
    final size = renderBox.size; // Get the size of the widget
    print("${size.height},${size.width}");
    final selection = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        (MediaQuery.of(context).size.width/2) ,  // X position, centered
        offset.dy-10 + 2*size.height,  // Y position, just below the widget
        (MediaQuery.of(context).size.width/2),
        offset.dy + size.height + 100,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
      elevation: 8.0,
    );

    if (selection == 'edit') {
      // Edit functionality (you can pass new name/image to onEdit)

    } else if (selection == 'delete') {
      // Close menu before opening the delete dialog
      _showDeleteDialog(context);

    }
  }
  void _showDeleteDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_rounded, size: 50, color: Colors.blueAccent), // Top icon
              SizedBox(height: 10),
              Text(
                "Are you sure?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Do you want to delete this employee?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close bottom sheet
                       // Call delete function
                      },
                      child: Text("Delete", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close bottom sheet
                      },
                      child: Text("Cancel", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }



}
