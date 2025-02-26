import 'package:codemasterhome/widgets/heading.dart';
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
              Heading(title:'Start Learning to Code for free'),
              CourseCard(CourseModel(image_asset: 'assets/images/flutter_banner.jpg',title: 'Introduction to Flutter',provideby: 'by flutter dev',duration: 'Grow More'),url: 'https://flutter.dev'),
              CourseCard(CourseModel(image_asset: 'assets/images/intro_to_html.jpg',title: 'Introduction to HTML',provideby: 'by W3Scool',duration: '4h 32m',),url: "https://www.w3schools.com/html/default.asp"),
              QuickAccessWidget(),

            ],
          ),
        ),
      ),
    );
  }

}
