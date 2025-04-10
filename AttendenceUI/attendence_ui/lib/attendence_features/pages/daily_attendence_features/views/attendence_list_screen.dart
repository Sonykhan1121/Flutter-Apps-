import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Colors/colors.dart';
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

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 25.w, right: 25.w),
            child: ListView.builder(
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
                        onTap: () {
                         (widget.status=='Absent')? showMessagePopup(context, "Send"):_showPopupMenu(context,_key);
                        },
                        child: SvgPicture.asset(
                          (widget.status=='Absent')?'assets/icons/message.svg':'assets/icons/employee_profile/row_icon.svg',
                          height: 24.h,
                        ),
                        // child: Icon(
                        //   (widget.status == "Absent") ? Icons.send : Icons.more_vert,
                        //   size: 24.w,
                        // ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: (widget.status == 'Absent')
              ? Padding(
            padding: EdgeInsets.all(20.h),
            child: SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  showMessagePopup(context, "Send to All");
                },
                // icon: Icon(Icons.send, color: Colors.white, size: 18),
                label: Text(
                  "Send Message to All",
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cl.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.w),
                  ),
                ),
              ),
            ),
          )
              : null,
        );
      },
    );
  }

  void showMessagePopup(BuildContext context,String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          content: SizedBox(
            width: MediaQuery.of(context).size.width ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    filled: true,
                    fillColor: Cl.primaryColor.withOpacity(0.1),

                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your message',
                    filled: true,
                    fillColor: Cl.primaryColor.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle send logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:  Text('Cancel',style: TextStyle(color: Cl.primaryColor,fontSize: 16.sp,),),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle send logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Cl.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (message=="Send")?16.sp:14.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
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
    // final employeeProvider = Provider.of<EmployeeProvider>(
    //   context,
    //   listen: false,
    // );

    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar with question mark
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade100,
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/icons/sure.svg",height: 30.sp,),
                  ),
                ),
                const SizedBox(height: 20),

                // Title text
                const Text(
                  'Are you sure?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Description text
                Text(
                  'Do you want to delete this Employee from overtime ?',
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Delete button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // print('id : ${widget.employee.employeeId}');
                          //
                          // employeeProvider.deleteEmployee(widget.employee.employeeId);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child:  Text('Delete'),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Cancel button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }




}
