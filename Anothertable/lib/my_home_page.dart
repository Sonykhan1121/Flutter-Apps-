import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dx = 50;
  double dy = 100;
  double tableWidth = 300;
  double tableHeight = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table')),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(children: [
              Container(color: Colors.grey[400]),
              Positioned(
                left: dx,
                top: dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      dx += details.delta.dx;
                      dy += details.delta.dy;
                    });
                  },
                  child: buildTable(),
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Add Table"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.rotate_right),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.keyboard_double_arrow_left),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.keyboard_double_arrow_right),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTable() {
    return Container(
      width: tableWidth,
      height: tableHeight,
      child: Stack(
        children: [
          // Main Table Content
          Table(
            border: TableBorder.all(color: Colors.black, width: 2),
            columnWidths: {
              0: FlexColumnWidth(0.2),
              1: FlexColumnWidth(0.4),
              2: FlexColumnWidth(0.4),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.blue.shade700),
                children: [
                  buildEditableTableCell("Id", isHeader: true),
                  buildEditableTableCell("Name", isHeader: true),
                  buildEditableTableCell("Status", isHeader: true),
                ],
              ),
              TableRow(
                children: [
                  buildEditableTableCell("1"),
                  buildEditableTableCell("Alice"),
                  buildEditableTableCell("Active"),
                ],
              ),
              TableRow(
                children: [
                  buildEditableTableCell("2"),
                  buildEditableTableCell("Bob"),
                  buildEditableTableCell("Inactive"),
                ],
              ),
              TableRow(
                children: [
                  buildEditableTableCell("3"),
                  buildEditableTableCell("Charlie"),
                  buildEditableTableCell("Active"),
                ],
              ),
            ],
          ),

          // Resize Handle - Always positioned at bottom right
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  // Implement resize logic with clamped values
                  tableWidth = (tableWidth + details.delta.dx).clamp(200.0, 500.0);
                  tableHeight = (tableHeight + details.delta.dy).clamp(100.0, 400.0);
                });
              },
              child: Container(
                width: 30,  // Slightly larger touch area
                height: 30, // Slightly larger touch area
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.open_with,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableTableCell(String text, {bool isHeader = false}) {
    return Center(
      child: TextField(
        controller: TextEditingController(text: text),
        decoration: InputDecoration(
          border: isHeader ? InputBorder.none : OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isHeader ? 18 : 16,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? Colors.white : Colors.black,
        ),
        readOnly: isHeader, // Make headers non-editable
      ),
    );
  }
}