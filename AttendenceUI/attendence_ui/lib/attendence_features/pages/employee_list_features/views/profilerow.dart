import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProfileRow extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Function onDelete;
  final Function(String, String) onEdit;

  ProfileRow({required this.name, required this.imageUrl, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final GlobalKey _key = GlobalKey();

    return GestureDetector(
      key: _key,
      onLongPress: () => _showPopupMenu(context),
      child: Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: Color(0x1A004368)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25.h,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(name, style: TextStyle(fontSize: 15.sp)),
            ),
            Icon(Icons.more_vert, size: 24.w),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final selection = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0, 0, 0, 0),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
      elevation: 8.0,
    );

    if (selection == 'edit') {
      // Edit functionality (you can pass new name/image to onEdit)
      onEdit('New Name', 'new_image_url');
    } else if (selection == 'delete') {
      onDelete();
    }
  }
}
