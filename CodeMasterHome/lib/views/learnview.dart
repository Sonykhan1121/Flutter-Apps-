import 'package:codemasterhome/models/course_model.dart';
import 'package:codemasterhome/utils/appColors.dart';
import 'package:codemasterhome/utils/appScale.dart';
import 'package:flutter/material.dart';

import '../widgets/course_card.dart';
import '../widgets/course_card2.dart';

class LearnView extends StatelessWidget {
  const LearnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CourseCard(
                CourseModel(
                  image_asset: "assets/images/lean_page_banner.png",
                  title: "Build Websites from Scratch",
                  provideby:
                      "Learn HTML, CSS, and other design tools to build websites and web applications.",
                  duration: "13 Lessons",
                ),
                url: "https://www.youtube.com/watch?v=h3bTwCqX4ns&list=PL4-IK0AVhVjNDRHoXGort7sDWcna8cGPA",
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Quick Access',
                    style: TextStyle(
                      fontFamily: "Noto Serif",
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w700,
                      fontSize: AppScale.scaleText(14, context),
                    ),
                  ),
                ),
              ),
              CourseCard2(
                courseModel: CourseModel(
                  image_asset: "assets/images/html_css.jpg",
                  title: "HTML & CSS",

                ),
                buttontext: 'Continue',
                url:"https://www.w3schools.com/html/default.asp",
              ),
              CourseCard2(
                courseModel: CourseModel(
                  image_asset: "assets/images/js.png",
                  title: "JavaScript",
                ),
                buttontext: 'Continue',
                  url:"https://www.javascripttutorial.net/",
              ),
              CourseCard2(
                courseModel: CourseModel(
                  image_asset: "assets/images/react.png",
                  title: "React",
                ),
                buttontext: 'Continue',
                url:"https://react-tutorial.app/",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
