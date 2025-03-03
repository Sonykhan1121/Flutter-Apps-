
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to login screen
          },
        ) ,
        title: Text("Employee List"),
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
                height: 50,
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
                    style: TextStyle(fontSize: 15, color: Colors.white),
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
    return Card(
      color: Colors.white,
      child: ListTile(
        key: _key,
        leading: CircleAvatar(
          backgroundImage: NetworkImage("https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
          radius: 20,
        ),
        title: Text(name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004368),
            )),
        trailing: Icon(Icons.more_vert, color: Color(0xFF004368)),
        onTap: () {
          // Define action on tap, e.g., open settings or show more options
          print('More options for $name');
        },
        onLongPress: (){
          _showPopupMenu(context);
        },
      ),
    );
  }
  void _showPopupMenu(BuildContext context) async {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero); // Get position
    final Size size = renderBox.size; // Get size of the widget

    // Calculate the left and right coordinates to center the menu horizontally
    final double screenWidth = MediaQuery.of(context).size.width;
    final double left = (screenWidth / 2) - (150 / 2); // Assuming menu width is about 150, adjust if necessary
    final double right = screenWidth - left - 150; // Same width assumption

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Icon(Icons.warning_amber_rounded, size: 40, color: Colors.blue), // Adjust color as needed
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Are you sure?", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Do you want to delete this Employee?"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF004368).withOpacity(0.3), // Dark grey
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the dialog but don't delete
                    },
                    child: Text("Cancel", style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Dark grey
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss and perform delete action
                      // Implement your delete functionality here
                      print('Employee $name deleted');
                    },
                    child: Text("Delete", style: TextStyle(color: Colors.white)),
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