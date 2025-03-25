import 'dart:math';

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
  double tableHeight = 100;
  double perRow = 4;
  double rotate = 0;

  // Store table data dynamically
  List<List<String>> tableData = [
    [" ", " "],
    [" ", " "],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Table')),
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
                  child: Transform.rotate(
                      angle:rotate,
                      child: buildTable()
                  ),
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
                  ElevatedButton.icon(onPressed: (){
                    setState(() {
                      rotate+=(pi/2);
                    });
                  }, label: Icon(Icons.rotate_right_sharp)),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tableData.add(List.generate(tableData[0].length, (index) => " "));
                      });
                    },
                    child: Text("Add Row"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (tableData.length > 1) {
                          tableData.removeLast();
                        }
                      });
                    },
                    child: Text("Remove Row"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        for (var row in tableData) {
                          row.add(" ");
                        }
                      });
                    },
                    child: Text("Add Column"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (tableData[0].length > 1) {
                          for (var row in tableData) {
                            row.removeLast();
                          }
                        }
                      });
                    },
                    child: Text("Remove Column"),
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
          LayoutBuilder(
            builder: (_, constraints) {
              tableHeight = constraints.maxHeight;

              return Table(
                border: TableBorder.all(color: Colors.black, width: 2),
                columnWidths: Map.fromIterable(
                  List.generate(tableData[0].length, (index) => index),
                  key: (index) => index,
                  value: (index) => FlexColumnWidth(1),
                ),
                children: tableData.map((row) {
                  return TableRow(
                    children: row.map((cell) => buildEditableTableCell(cell)).toList(),
                  );
                }).toList(),
              );
            },
          ),

          // Resize Handle - Positioned at bottom-right
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  tableWidth = (tableWidth + details.delta.dx).clamp(200.0, 500.0);
                  tableHeight = (tableHeight + details.delta.dy).clamp(100.0, 400.0);
                  perRow += details.delta.dy;
                });
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.7),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                ),
                child: Center(
                  child: Icon(Icons.open_with, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditableTableCell(String text) {
    return Center(
      child: TextField(
        controller: TextEditingController(text: text),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: perRow.clamp(4, 100)),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }
}
