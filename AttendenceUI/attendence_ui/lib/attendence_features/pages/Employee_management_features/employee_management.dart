import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({Key? key}) : super(key: key);

  @override
  _EmployeeManagementScreenState createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  // Track expanded states
  Map<String, bool> _expandedState = {
    'workType': false,
    'attendanceMethod': false,
    'visibleInfo': false,
  };

  // Selected values
  String _selectedWorkType = 'Home';
  String _selectedAttendanceMethod = 'Check out button';
  Map<String, bool> _selectedVisibleInfo = {
    'Daily attendance': false,
    'Late punch': false,
    'Absents': false,
    'Late in': false,
    'Overtimes': false,
    'Weekly activities': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.grey),
        title: const Text(
          'Employee Management',
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Work Type Section
                CollapsibleSection(
                  title: 'Choose employee work type',
                  isExpanded: _expandedState['workType'] ?? false,
                  onTap: () {
                    setState(() {
                      _expandedState['workType'] = !(_expandedState['workType'] ?? false);
                    });
                  },
                  expandedContent: Column(
                    children: [
                      _buildRadioOption('Home', _selectedWorkType, (value) {
                        setState(() {
                          _selectedWorkType = value!;
                        });
                      }),
                      _buildRadioOption('Onsite', _selectedWorkType, (value) {
                        setState(() {
                          _selectedWorkType = value!;
                        });
                      }),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Attendance Method Section
                CollapsibleSection(
                  title: 'Choose attendance method for employee',
                  isExpanded: _expandedState['attendanceMethod'] ?? false,
                  onTap: () {
                    setState(() {
                      _expandedState['attendanceMethod'] = !(_expandedState['attendanceMethod'] ?? false);
                    });
                  },
                  expandedContent: Column(
                    children: [
                      _buildRadioOption('Check out button', _selectedAttendanceMethod, (value) {
                        setState(() {
                          _selectedAttendanceMethod = value!;
                        });
                      }),
                      _buildRadioOption('Face attendance', _selectedAttendanceMethod, (value) {
                        setState(() {
                          _selectedAttendanceMethod = value!;
                        });
                      }),
                      _buildRadioOption('Both', _selectedAttendanceMethod, (value) {
                        setState(() {
                          _selectedAttendanceMethod = value!;
                        });
                      }),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Visible Information Section
                CollapsibleSection(
                  title: 'Choose which information\'s employee can see',
                  isExpanded: _expandedState['visibleInfo'] ?? false,
                  onTap: () {
                    setState(() {
                      _expandedState['visibleInfo'] = !(_expandedState['visibleInfo'] ?? false);
                    });
                  },
                  expandedContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _selectedVisibleInfo.values.every((value) => value),
                              onChanged: (value) {
                                setState(() {
                                  for (var key in _selectedVisibleInfo.keys) {
                                    _selectedVisibleInfo[key] = value!;
                                  }
                                });
                              },
                            ),
                            const Text('Select all', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      ..._selectedVisibleInfo.keys.map((option) {
                        return _buildCheckboxOption(option, _selectedVisibleInfo[option]!, (value) {
                          setState(() {
                            _selectedVisibleInfo[option] = value!;
                          });
                        });
                      }).toList(),
                    ],
                  ),
                ),
                const Divider(height: 1),

                const SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D74),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      )
                    ),
                    child:  Text('Save', style: TextStyle(fontSize: 16.sp,color:Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, String groupValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Radio<String>(
            value: label,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: const Color(0xFF004D74),
          ),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCheckboxOption(String label, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF004D74),
          ),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class CollapsibleSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;
  final Widget expandedContent;

  const CollapsibleSection({
    Key? key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.expandedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
            child: expandedContent,
          ),
      ],
    );
  }
}