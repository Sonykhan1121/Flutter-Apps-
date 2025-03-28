import 'package:attendence_ui/attendence_features/models/employee.dart';
import 'package:attendence_ui/attendence_features/pages/employee_list_features/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileRow extends StatefulWidget {
  final Employee employee;

  ProfileRow({required this.employee});

  @override
  State<ProfileRow> createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  @override
  Widget build(BuildContext context) {
    print("salary : ${widget.employee.salary}");

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
            backgroundImage:
                widget.employee.imageFile == null
                    ? AssetImage("assets/images/profile_1.png")
                    : MemoryImage(
                      widget.employee.imageFile,
                    ), // Use MemoryImage to load image from bytes
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              widget.employee.name,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          GestureDetector(
            key: _key,
            onTap: () => _showPopupMenu(context, _key),
            child: Icon(Icons.more_vert, size: 24.w),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context, GlobalKey key) async {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(
      Offset.zero,
    ); // Get the position of the widget
    final size = renderBox.size; // Get the size of the widget
    print("${size.height},${size.width}");
    final selection = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        (MediaQuery.of(context).size.width / 2), // X position, centered
        offset.dy - 10 + 2 * size.height, // Y position, just below the widget
        (MediaQuery.of(context).size.width / 2),
        offset.dy + size.height + 100,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(leading: Icon(Icons.edit), title: Text('Edit')),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(leading: Icon(Icons.delete), title: Text('Delete')),
        ),
      ],
      elevation: 8.0,
    );

    if (selection == 'edit') {
      _showPopupDialog();

      // pop dialog text field will open
      // Open a dialog with input field for the new name
    } else if (selection == 'delete') {
      // Close menu before opening the delete dialog
      _showDeleteDialog(context);
    }
  }

  void _showPopupDialog() {
    TextEditingController nameController = TextEditingController();


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter New Name"),
          content: TextField(

            controller: nameController,
            decoration: InputDecoration(
              hintText: "New Name",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final employeeProvider = Provider.of<EmployeeProvider>(
                  context,
                  listen: false,
                );

                employeeProvider.editEmployee(
                  widget.employee.id!,
                  widget.employee.name!,
                  nameController.text.toString(),
                );
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(
      context,
      listen: false,
    );
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(30),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_rounded, size: 50, color: Color(0xFF004368)),
              // Top icon
              SizedBox(height: 10),
              Text(
                "Are you sure?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Do you want to delete this employee?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF004368)),
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
                        print('id : ${widget.employee.id}');

                        employeeProvider.deleteEmployee(widget.employee.id!);
                        Navigator.of(context).pop(); // Close bottom sheet
                        // Call delete function
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
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
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
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
