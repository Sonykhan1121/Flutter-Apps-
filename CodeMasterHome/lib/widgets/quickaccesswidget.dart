import 'package:codemasterhome/widgets/progress_item.dart';
import 'package:flutter/material.dart';

import '../models/progress_item_model.dart';
import '../utils/appScale.dart';

class QuickAccessWidget extends StatefulWidget {
  const QuickAccessWidget({super.key});

  @override
  State<QuickAccessWidget> createState() => _QuickAccessWidgetState();
}

class _QuickAccessWidgetState extends State<QuickAccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick access',
            style: TextStyle(fontFamily:"NotoSerif",fontSize: AppScale.scaleText(22, context),fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          ProgressItem(progressItemModel: ProgressItemModel(title: 'ReactJS', progress: 0.8),),
          SizedBox(height: 20),
          ProgressItem(progressItemModel: ProgressItemModel(title: 'Python', progress: 0.6),),
          SizedBox(height: 20),
          ProgressItem(progressItemModel: ProgressItemModel(title: 'Data Science', progress: 0.4),),
          SizedBox(height: 20),

        ],
      ),
    );
  }
}
  