import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/image_model.dart';
import 'package:to_do_list/providers/task_provider.dart';
import 'package:to_do_list/providers/theme_provider.dart';

class DrawingListView extends StatefulWidget {
  final TaskProvider provider;

  const DrawingListView({super.key, required this.provider});

  @override
  State<DrawingListView> createState() => _DrawingListViewState();
}

class _DrawingListViewState extends State<DrawingListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.provider.images.length,
      itemBuilder: (context, index) {
        ImageModel imageModel = widget.provider.images[index];
        return InkWell(
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete",style:TextStyle(color:Theme.of(context).colorScheme.onError) ,),
                    content: Text('Do you want to delete this?',style:TextStyle(color:Theme.of(context).colorScheme.onError),),
                    actions: [

                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      ElevatedButton(
                          onPressed: () {
                            widget.provider.deleteImagePath(imageModel.id);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg:
                                    'Deleted image at index: ${imageModel.id}');
                          },
                          child: Text('Yes')),
                    ],
                    elevation: 24.0,
                    backgroundColor: Provider.of<ThemeProvider>(context)
                        .themeData.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                });
          },
          child: Card(
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.file(File(imageModel.path)),
          ),
        );
      },
    );
  }
}
