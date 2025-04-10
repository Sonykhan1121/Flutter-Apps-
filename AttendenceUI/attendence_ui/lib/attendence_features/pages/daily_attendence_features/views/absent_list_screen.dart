import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../Colors/colors.dart';

class AbsentListScreen extends StatefulWidget {
  final String status;

  const AbsentListScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<AbsentListScreen> createState() => _AbsentListScreenState();
}

class _AbsentListScreenState extends State<AbsentListScreen> {
  List<Map<String, String>> data = [
    {'name': 'Md Alamin', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/74.jpg'},
    {'name': 'Sakib Hasan', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/30.jpg'},
    {'name': 'Tanvir Ahammed', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/31.jpg'},
    {'name': 'Md Alamin', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/35.jpg'},
    {'name': 'Sakib Hasan', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/25.jpg'},
    {'name': 'Tanvir Ahammed', 'image': 'https://xsgames.co/randomusers/assets/avatars/male/76.jpg'},
  ];

  bool isSelectionMode = false;
  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final GlobalKey _key = GlobalKey();
            final isSelected = selectedIndexes.contains(index);

            return GestureDetector(
              onLongPress: () {

                  setState(() {
                    isSelectionMode = true;
                    selectedIndexes.add(index);
                  });

              },
              onTap: () {
                if (isSelectionMode) {
                  setState(() {
                    if (isSelected) {
                      selectedIndexes.remove(index);
                      if (selectedIndexes.isEmpty) isSelectionMode = false;
                    } else {
                      selectedIndexes.add(index);
                    }
                  });
                }
              },
              child: Container(
                height: 60.h,
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Color(0x1A004368)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isSelectionMode)
                      Checkbox(

                        activeColor:Cl.primaryColor ,
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value!) {
                              selectedIndexes.add(index);
                            } else {
                              selectedIndexes.remove(index);
                              if (selectedIndexes.isEmpty) isSelectionMode = false;
                            }
                          });
                        },
                      )
                    ,
                      CircleAvatar(
                        radius: 25.h,
                        backgroundImage: NetworkImage(data[index]['image']!),
                      ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        data[index]['name']!,
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    if (!isSelectionMode)
                      GestureDetector(
                        key: _key,
                        onTap: () {
                          showMessagePopup(context, "Send");

                        },
                        child: SvgPicture.asset(

                               'assets/icons/message.svg'
                              ,
                          height: 24.h,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.h),
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton.icon(
            onPressed: () {
              if (isSelectionMode && selectedIndexes.isNotEmpty) {
                showMessagePopup(context, "Send to Selected (${selectedIndexes.length})");
              } else {
                showMessagePopup(context, "Send to All");
              }
            },
            icon: Icon(Icons.send, color: Colors.white, size: 20),
            label: Text(
              isSelectionMode
                  ? "Send Message to Selected (${selectedIndexes.length})"
                  : "Send Message to All",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Cl.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.w),
              ),
            ),
          ),
        ),
      )
          ,
    );
  }
  void showMessagePopup(BuildContext context,String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
          content: SizedBox(
            width: MediaQuery.of(context).size.width ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    filled: true,
                    fillColor: Cl.primaryColor.withOpacity(0.1),

                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your message',
                    filled: true,
                    fillColor: Cl.primaryColor.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle send logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child:  Text('Cancel',style: TextStyle(color: Cl.primaryColor,fontSize: 16.sp,),),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle send logic
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Cl.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: (message=="Send")?16.sp:12.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }


}
