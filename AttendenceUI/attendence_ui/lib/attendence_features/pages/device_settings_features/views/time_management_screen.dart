import 'package:flutter/material.dart';
class TimeManagementScreen extends StatefulWidget {
  @override
  _TimeManagementScreenState createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  List<bool> isSelected = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Management"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectHolidaySection(isSelected: isSelected),
            SizedBox(height: 20),
            OfficeTimeSettings(),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectHolidaySection extends StatelessWidget {
  final List<bool> isSelected;

  SelectHolidaySection({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Holiday", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        ToggleButtons(
          isSelected: isSelected,
          onPressed: (int index) {
            // Respond to button selection
            for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
              if (buttonIndex == index) {
                isSelected[index] = !isSelected[index];
              }
            }
          },
          children: <Widget>[
            Text("Sun"),
            Text("Mon"),
            Text("Tue"),
            Text("Wed"),
            Text("Thu"),
            Text("Fri"),
            Text("Sat"),
          ],
          borderRadius: BorderRadius.circular(8),
          fillColor: Colors.blue,
          selectedColor: Colors.white,
          color: Colors.black,
        ),
      ],
    );
  }
}

class OfficeTimeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Office time settings", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TimeSetting(label: "Start Time"),
        TimeSetting(label: "End Time"),
        TimeSetting(label: "Tea Break"),
        TimeSetting(label: "Lunch Break"),
      ],
    );
  }
}

class TimeSetting extends StatelessWidget {
  final String label;

  TimeSetting({required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.watch_later_outlined),
      title: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          // Implement time picker functionality
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            // Handle the picked time
            print(pickedTime.format(context));
          }
        },
      ),
    );
  }
}