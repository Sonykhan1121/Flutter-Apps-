import 'package:codemasterhome/models/progress_item_model.dart';
import 'package:flutter/material.dart';

import '../utils/appColors.dart';

class ProgressItem extends StatefulWidget {
  final ProgressItemModel progressItemModel;
  const ProgressItem({required this.progressItemModel, super.key});

  @override
  State<ProgressItem> createState() => _ProgressItemState();
}

class _ProgressItemState extends State<ProgressItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.progressItemModel.title!,
                style: TextStyle(
                  fontFamily: "NotoSerif",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Completed ${widget.progressItemModel.progress*100}%',
                style: TextStyle(
                  fontFamily: "NotoSerif",
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: constraints.maxWidth * widget.progressItemModel.progress,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(width: 10),
        Text(
          "${widget.progressItemModel.progress * 100}%",
          style: TextStyle(
            fontFamily: "NotoSerif",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}