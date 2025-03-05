
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Colors/colors.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final List<Map<String, dynamic>> profiles = [
    {"name": "Devon Lane", "image": ""},
    {"name": "Alex Jane", "image": ""},
    {"name": "Sam Pat", "image": ""},
    // Add more profiles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to login screen
          },
        ) ,
        title: Text("Employee List",style: TextStyle(fontSize: 20.sp,color: Colors.black.withOpacity(0.6)),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return ProfileRow(
                    name: profiles[index]['name'],
                    imageUrl: profiles[index]['image'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004368), // Dark blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Employee",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String name;
  final String imageUrl;
  final GlobalKey _key = GlobalKey();

  ProfileRow({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

     return GestureDetector(
       key: _key,
       onLongPress: (){
         _showPopupMenu(context);
       },
       child: Container(
        height: 60.h,  // Set height to 60px
        margin: EdgeInsets.symmetric(vertical: 6),  // Spacing between items
        padding: EdgeInsets.symmetric(horizontal: 12), // Padding inside the container
        decoration: BoxDecoration(
          color: Colors.white,  // Background color
          borderRadius: BorderRadius.circular(9),  // Border radius
          border: Border.all(color: Color(0x1A004368)), // 1px solid rgba(0, 67, 104, 0.10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items
          crossAxisAlignment: CrossAxisAlignment.center, // Center align vertically
          children: [
            CircleAvatar(
              radius: 25.h,  // Image size 50px (diameter)
              backgroundImage: NetworkImage("https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg"),
            ),
            SizedBox(width: 10.w), // Spacing between avatar and text
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            Icon(Icons.more_vert, size: 24.w),
          ],
        ),
           ),
     );
  }
  void _showPopupMenu(BuildContext context) async {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero); // Get position
    final Size size = renderBox.size; // Get size of the widget

    // Calculate the left and right coordinates to center the menu horizontally
    final double screenWidth = MediaQuery.of(context).size.width;
    final double left = (screenWidth / 2) - (150.w / 2); // Assuming menu width is about 150, adjust if necessary
    final double right = screenWidth - left - 150.w; // Same width assumption

    final selection = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        offset.dy + size.height,
        right,
        offset.dy,
      ), // Position menu below the tile and center horizontally
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit,color: Cl.primaryColor,),
            title: Text('Edit',style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Cl.primaryColor)),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete,color: Cl.primaryColor,),
            title: Text('Delete',style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Cl.primaryColor)),
          ),
        ),
      ],
      elevation: 8.0,
    );

    // Handle the action based on the selection
    if (selection == 'edit') {
      print('Edit clicked for $name');
      // Implement your edit functionality here
    } else if (selection == 'delete') {
      print('Delete clicked for $name');
      _showDeleteConfirmation(context,name);
      // Implement your delete functionality here
    }
  }
  void _showDeleteConfirmation(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          title: Icon(Icons.warning_amber_rounded, size: 28.sp, color: Colors.blue), // Adjust color as needed
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Are you sure?", style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500)),
              SizedBox(height: 6.h),
              Text("Do you want to delete this Employee?",style: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 12.sp),),
              SizedBox(height: 26.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004368).withOpacity(0.3), // Dark grey
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog but don't delete
                    },
                    child: Text("Cancel", style: TextStyle(fontSize:15.sp,color: Cl.primaryColor)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Dark grey
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss and perform delete action
                      // Implement your delete functionality here
                      print('Employee $name deleted');
                    },
                    child: Text("Delete", style: TextStyle(fontSize:15.sp,color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}