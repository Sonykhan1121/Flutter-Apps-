import 'package:flutter/material.dart';

import '../utils/appScale.dart';
class Heading extends StatelessWidget {
  final String title;
  const Heading({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16,top: 20,right: 16,bottom: 12),

      child: Text(
        title,
        textAlign:TextAlign.start,
        style: TextStyle(fontFamily:"NotoSerif",fontSize: AppScale.scaleText(22, context),fontWeight: FontWeight.w700),
      ),
    );;
  }
}
