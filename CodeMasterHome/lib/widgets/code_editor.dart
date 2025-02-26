import 'package:flutter/material.dart';

import '../utils/appScale.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your code',
              style: TextStyle(
                fontFamily: "Noto Serif",
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: AppScale.scaleText(16, context),
              ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              maxLines: 5, // Make the text field multiple lines
              decoration: InputDecoration(
                hintText: "Type your code here",
                border: InputBorder.none, // Remove underline
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Code to execute when Run is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.amber, // Text color
                    ),
                    child: Text('Run',
                      style: TextStyle(
                        fontFamily: "Noto Serif",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: AppScale.scaleText(14, context),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300], // Text color
                    ),
                    child: Text('Reset'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}