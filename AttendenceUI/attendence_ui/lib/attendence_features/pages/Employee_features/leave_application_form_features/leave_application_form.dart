import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../Colors/colors.dart';

class LeaveApplicationForm extends StatefulWidget {
  String? description;

  LeaveApplicationForm({this.description, Key? key}) : super(key: key);

  @override
  _LeaveApplicationFormState createState() => _LeaveApplicationFormState();
}

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _startDate = DateTime(2025, 4, 1);
  DateTime _endDate = DateTime(2025, 4, 4);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.description != null) {
      _descriptionController.text = widget.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Cl.primaryColor.withOpacity(0.6)),
        title: Text(
          'Leave Application',
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Approver Name',
              style: TextStyle(
                fontSize: 14.sp,
                color: Cl.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                // When TextField is not focused
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD6E6F0),
                  ), // light blue border
                ),

                // When TextField is focused
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Cl.primaryColor,
                    width: 1,
                  ), // dark blue border
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(
                color: Cl.primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Describe your problems',
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                // When TextField is not focused
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD6E6F0),
                  ), // light blue border
                ),

                // When TextField is focused
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Cl.primaryColor,
                    width: 1,
                  ), // dark blue border
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Leave Category',
              style: TextStyle(
                color: Cl.primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildSelectionField('select leave category'),
            const SizedBox(height: 16),
            Text(
              'Leave Type',
              style: TextStyle(
                fontSize: 14.sp,
                color: Cl.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildSelectionField('select leave type'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave Start Day',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Cl.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDateField(_startDate),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leave End Day',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Cl.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDateField(_endDate),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Attach Documents',
              style: TextStyle(
                fontSize: 14.sp,
                color: Cl.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD6E6F0)),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose file',
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/icons/attachment_employee.svg",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            (widget.description == null)
                ? Container(
                  width: double.infinity,
                  height: 50.h,

                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Cl.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.sp),
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Reject Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle reject action
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          side: BorderSide(color: Colors.red, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Reject',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 18.w),
                    // Approve Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Handle approve action
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green.shade50,
                          side: BorderSide(color: Colors.green, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Approve',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionField(String hintText) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD6E6F0)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        title: Text(hintText, style: const TextStyle(color: Colors.grey)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.sp),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  Widget _buildDateField(DateTime date) {
    final formattedDate = DateFormat('dd MMMM yyyy').format(date);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD6E6F0)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        title: Text(
          formattedDate,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () async {
          // Date picker logic would go here
        },
        dense: true,
      ),
    );
  }
}
