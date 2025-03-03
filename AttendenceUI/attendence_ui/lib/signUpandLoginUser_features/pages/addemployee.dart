import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Employee',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // Allow overlapping
              children: [
                // Circular Profile Avatar
                Container(
                  width: 133,
                  height: 148,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2,color: Colors.blue),
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Top color
                        Colors.blueAccent, // Bottom quarter color
                      ],
                      stops: [0.75, 1.0], // 75% is blue, 25% is red
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.person, color: Colors.blue.shade900, size: 50),
                  ),
                ),
                // Camera Icon Positioned at Bottom-Center
                Positioned(

                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 20,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Input Fields
            buildTextField("Full Name", "Full Name"),
            buildTextField("Employee ID", "AB000000000"),
            buildTextField("Designation", "Designation"),
            buildTextField("Address", "Employee Address"),
            buildTextField("Email Address", "employee@gmail.com"),
            buildTextField("Contact Number", "+00 12345 67890"),
            buildTextField("Salary", "\$1000"),
            buildTextField("Overtime Rate", "\$10"),

            SizedBox(height: 20),

            // Recognize Face Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/button_icon.svg",  // Path to your SVG
                  width: 24,  // Set size
                  height: 24,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),  // Set color
                ),
                label: Text("Recognize Face", style: TextStyle(fontSize: 16, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF004368),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14,color: Color(0xFF004368), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: placeholder,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0x66004368)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

