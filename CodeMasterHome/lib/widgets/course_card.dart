import 'package:codemasterhome/widgets/stylish_webview.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../utils/appColors.dart';
import '../utils/appScale.dart';

class CourseCard extends StatefulWidget {
  final CourseModel courseModel;
  final String url;

  CourseCard(this.courseModel,{required this.url});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.4,
      // Adjusted for 40% of the screen height
      margin: EdgeInsets.all(16),
      // Spacing around the card
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Shadow positioning
          ),
        ],
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.courseModel.image_asset!),
                  // Adjust your image asset path
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ), // Rounded corners at the top
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              // Padding inside the bottom part of the card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // This will provide even spacing
                children: [
                  Text(
                widget.courseModel.title!,
                    style: TextStyle(
                      fontFamily: "NotoSerif",
                      fontWeight: FontWeight.bold,
                      fontSize: AppScale.scaleText(18, context),
                    ),
                  ),
                  Text(
                    widget.courseModel.provideby!
                    ,
                    style: TextStyle(
                      fontFamily: "NotoSerif",
                      fontWeight: FontWeight.normal,
                      fontSize: AppScale.scaleText(16, context),
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    widget.courseModel.duration!
                    ,
                    style: TextStyle(
                      fontFamily: "NotoSerif",
                      fontWeight: FontWeight.normal,
                      fontSize: AppScale.scaleText(16, context),
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Provides space between the last text and the button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>StylishWebview(url: widget.url,title: widget.courseModel.title,)));
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.bottomRight,
                        backgroundColor: AppColors.secondary,
                        // Background color
                        foregroundColor: Colors.black,
                        // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Start Learning',
                        style: TextStyle(
                          fontFamily: "NotoSerif",
                          fontWeight: FontWeight.normal,
                          fontSize: AppScale.scaleText(14, context),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
