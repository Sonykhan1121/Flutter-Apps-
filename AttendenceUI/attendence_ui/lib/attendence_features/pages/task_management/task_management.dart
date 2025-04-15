import 'package:attendence_ui/attendence_features/pages/task_management/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../Colors/colors.dart';

class TaskManagementScreen extends StatefulWidget {
  int? count;

  TaskManagementScreen({this.count});

  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<TestEmployee> allEmployees = [
    TestEmployee(
      name: 'Devon Lane',
      id: '001',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    TestEmployee(
      name: 'Jane Doe',
      id: '002',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    TestEmployee(
      name: 'John Smith',
      id: '003',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
    TestEmployee(
      name: 'Alice',
      id: '004',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
    ),
    TestEmployee(
      name: 'Bob',
      id: '005',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
    ),
  ];

  List<TestEmployee> selectedEmployees = [];

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.count==null)Text(
                "Select Employee",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Cl.primaryColor,
                ),
              ),
              if(widget.count==null)SizedBox(height: 8),
              if(widget.count==null)TypeAheadField<TestEmployee>(
                controller: _searchController,
                suggestionsCallback: (pattern) async {
                  return Future.value(
                    allEmployees
                        .where(
                          (e) =>
                              e.name.toLowerCase().contains(
                                pattern.toLowerCase(),
                              ) ||
                              e.id.contains(pattern),
                        )
                        .toList(), // convert to List!
                  );
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Search by Id or Name',
                      suffixIcon: Icon(Icons.search),
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
                  );
                },
                itemBuilder: (context, TestEmployee suggestion) {
                  final alreadySelected = selectedEmployees.contains(
                    suggestion,
                  );
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(suggestion.avatarUrl),
                    ),
                    title: Text('${suggestion.name} (${suggestion.id})'),
                    trailing:
                        alreadySelected
                            ? Icon(Icons.check_circle, color: Cl.primaryColor)
                            : null,
                  );
                },
                onSelected: (TestEmployee value) {
                  if (!selectedEmployees.contains(value)) {
                    setState(() {
                      selectedEmployees.add(value);
                    });
                  }
                  _searchController.clear();
                },
              ),
              if(widget.count==null)SizedBox(height: 16),
              Text(
                "Selected Employee",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Cl.primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    selectedEmployees.map((employee) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(employee.avatarUrl),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmployees.remove(employee);
                              });
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),
              SizedBox(height: 24),
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Cl.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Task title',
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

              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 50.h,

                child: ElevatedButton(
                  onPressed: () {
                    // Save logic
                    print("Task Saved");
                    print("Title: ${_titleController.text}");
                    print("Description: ${_descriptionController.text}");
                    print(
                      "Employees: ${selectedEmployees.map((e) => e.name).join(', ')}",
                    );

                    taskProvider.addTasks(_titleController.text, selectedEmployees.length);

                    setState(() {
                      _titleController.clear();
                      _descriptionController.clear();
                      selectedEmployees.clear();
                    });
                    FocusScope.of(context).unfocus();
                    Future.delayed(Duration(seconds: 2));
                    showSuccessPopup(context);

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cl.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.sp),
                    ),
                  ),
                  child: Text(
                    'Save Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showSuccessPopup(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Text("New Task Added Successfully"),
        ],
      ),
      backgroundColor: Color(0xFF004368),
      // Primary color
      duration: Duration(seconds: 2),
      // Auto-dismiss after 2 seconds
      behavior: SnackBarBehavior.floating,
      // Floating style
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class TestEmployee {
  final String name;
  final String id;
  final String avatarUrl;

  TestEmployee({required this.name, required this.id, required this.avatarUrl});
}
