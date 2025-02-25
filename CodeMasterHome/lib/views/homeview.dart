import 'package:codemasterhome/widgets/quickaccesswidget.dart';
import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../widgets/course_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            children: [
              Container(

                padding: EdgeInsets.only(left: 16,top: 20,right: 16,bottom: 12),

                child: Text(
                  'Start Learning to Code for free',
                  textAlign:TextAlign.start,
                  style: TextStyle(fontFamily:"NotoSerif",fontSize: 28,fontWeight: FontWeight.w700),
                ),
              ),
              CourseCard(CourseModel(image_asset: 'assets/images/course_cover.jpg',title: 'Introduction to HTML',provideby: 'by Codecademy',duration: '3h 14m')),
              CourseCard(CourseModel(image_asset: 'assets/images/course_cover1.jpg',title: 'Learn Python',provideby: 'by Codecademy',duration: '4h 32m',)),
              QuickAccessWidget(),

            ],
          ),
        ),
      ),
    );
  }
}
