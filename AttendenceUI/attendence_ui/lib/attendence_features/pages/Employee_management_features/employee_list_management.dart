import 'package:attendence_ui/attendence_features/pages/Employee_management_features/employee_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Colors/colors.dart';

class MEmployee {
  final String id;
  final String name;
  final String imageUrl;
  final String department;
  final String jobTitle;
  final String location;
  final String employmentType;
  final DateTime hireDate;

  MEmployee({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.department,
    required this.jobTitle,
    required this.location,
    required this.employmentType,
    required this.hireDate,
  });
}

class EmployeeListManagement extends StatefulWidget {
  EmployeeListManagement({Key? key}) : super(key: key);

  @override
  _EmployeeManagementScreenState createState() =>
      _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeListManagement> {
  final TextEditingController _searchController = TextEditingController();
  List<MEmployee> _allEmployees = [];
  List<MEmployee> _filteredEmployees = [];
  Set<String> _selectedEmployeeIds = {};
  bool _isMultiSelectMode = false;
  Map<String, dynamic> _activeFilters = {};

  @override
  void initState() {
    super.initState();
    _loadEmployees();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadEmployees() {
    // Mockup data
    _allEmployees = [
      MEmployee(
        id: '1',
        name: 'Devon Lane',
        imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        department: 'Engineering',
        jobTitle: 'Senior Developer',
        location: 'New York',
        employmentType: 'Full-time',
        hireDate: DateTime(2020, 5, 15),
      ),
      MEmployee(
        id: '2',
        name: 'Theresa Webb',
        imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        department: 'Marketing',
        jobTitle: 'Marketing Manager',
        location: 'San Francisco',
        employmentType: 'Full-time',
        hireDate: DateTime(2019, 3, 10),
      ),
      MEmployee(
        id: '3',
        name: 'Jared Goodman',
        imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
        department: 'Sales',
        jobTitle: 'Sales Representative',
        location: 'Chicago',
        employmentType: 'Full-time',
        hireDate: DateTime(2021, 1, 5),
      ),
      MEmployee(
        id: '4',
        name: 'Nina Patel',
        imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        department: 'HR',
        jobTitle: 'HR Specialist',
        location: 'Boston',
        employmentType: 'Part-time',
        hireDate: DateTime(2022, 7, 20),
      ),
      MEmployee(
        id: '5',
        name: 'Cameron Price',
        imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
        department: 'Finance',
        jobTitle: 'Financial Analyst',
        location: 'Miami',
        employmentType: 'Contract',
        hireDate: DateTime(2023, 2, 12),
      ),
      MEmployee(
        id: '6',
        name: 'Lila Carter',
        imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        department: 'Design',
        jobTitle: 'UI/UX Designer',
        location: 'Seattle',
        employmentType: 'Full-time',
        hireDate: DateTime(2021, 9, 3),
      ),
      MEmployee(
        id: '7',
        name: 'Pablo Rivera',
        imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        department: 'Engineering',
        jobTitle: 'DevOps Engineer',
        location: 'Austin',
        employmentType: 'Full-time',
        hireDate: DateTime(2022, 4, 8),
      ),
      MEmployee(
        id: '8',
        name: 'Eva Nguyen',
        imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
        department: 'Product',
        jobTitle: 'Product Manager',
        location: 'Portland',
        employmentType: 'Full-time',
        hireDate: DateTime(2020, 11, 17),
      ),
      MEmployee(
        id: '9',
        name: 'Omar Silva',
        imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
        department: 'Customer Support',
        jobTitle: 'Support Specialist',
        location: 'Denver',
        employmentType: 'Full-time',
        hireDate: DateTime(2021, 8, 30),
      ),
      MEmployee(
        id: '10',
        name: 'Sofia Rodriguez',
        imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
        department: 'Marketing',
        jobTitle: 'Content Creator',
        location: 'Los Angeles',
        employmentType: 'Part-time',
        hireDate: DateTime(2023, 5, 25),
      ),
    ];

    _filteredEmployees = List.from(_allEmployees);
  }

  void _onSearchChanged() {
    _filterEmployees();
  }

  void _filterEmployees() {
    final String query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty && _activeFilters.isEmpty) {
        _filteredEmployees = List.from(_allEmployees);
      } else {
        _filteredEmployees =
            _allEmployees.where((employee) {
              bool matchesSearch =
                  query.isEmpty || employee.name.toLowerCase().contains(query);

              bool matchesFilters = true;

              // Apply department filter
              if (_activeFilters.containsKey('department') &&
                  _activeFilters['department'] != null &&
                  _activeFilters['department'] != 'All') {
                matchesFilters =
                    matchesFilters &&
                    employee.department == _activeFilters['department'];
              }

              // Apply job title filter
              if (_activeFilters.containsKey('jobTitle') &&
                  _activeFilters['jobTitle'] != null &&
                  _activeFilters['jobTitle'] != 'All') {
                matchesFilters =
                    matchesFilters &&
                    employee.jobTitle == _activeFilters['jobTitle'];
              }

              // Apply location filter
              if (_activeFilters.containsKey('location') &&
                  _activeFilters['location'] != null &&
                  _activeFilters['location'] != 'All') {
                matchesFilters =
                    matchesFilters &&
                    employee.location == _activeFilters['location'];
              }

              // Apply employment type filter
              if (_activeFilters.containsKey('employmentType') &&
                  _activeFilters['employmentType'] != null &&
                  _activeFilters['employmentType'] != 'All') {
                matchesFilters =
                    matchesFilters &&
                    employee.employmentType == _activeFilters['employmentType'];
              }

              // Apply hire date filter (if exists)
              if (_activeFilters.containsKey('hireDateFrom') &&
                  _activeFilters['hireDateFrom'] != null) {
                matchesFilters =
                    matchesFilters &&
                    employee.hireDate.isAfter(_activeFilters['hireDateFrom']);
              }

              if (_activeFilters.containsKey('hireDateTo') &&
                  _activeFilters['hireDateTo'] != null) {
                matchesFilters =
                    matchesFilters &&
                    employee.hireDate.isBefore(_activeFilters['hireDateTo']);
              }

              return matchesSearch && matchesFilters;
            }).toList();
      }
    });
  }

  void _toggleEmployeeSelection(String employeeId) {
    setState(() {
      if (_selectedEmployeeIds.contains(employeeId)) {
        _selectedEmployeeIds.remove(employeeId);
        if (_selectedEmployeeIds.isEmpty) {
          _isMultiSelectMode = false;
        }
      } else {
        _selectedEmployeeIds.add(employeeId);
      }
    });
  }

  void _onEmployeeTap(String employeeId) {
    if (_isMultiSelectMode) {
      _toggleEmployeeSelection(employeeId);
    } else {
      // Navigate to employee details or perform single selection action
      _selectedEmployeeIds = {employeeId};
      _navigateToRulesPage();
    }
  }

  void _onEmployeeLongPress(String employeeId) {
    setState(() {
      _isMultiSelectMode = true;
      _toggleEmployeeSelection(employeeId);
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildFilterBottomSheet(),
    );
  }

  Widget _buildFilterBottomSheet() {
    final departments = [
      'All',
      'Engineering',
      'Marketing',
      'Sales',
      'HR',
      'Finance',
      'Design',
      'Product',
      'Customer Support',
    ];
    final employmentTypes = ['All', 'Full-time', 'Part-time', 'Contract'];

    return StatefulBuilder(
      builder: (context, setSheetState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Options',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        // Department filter
                        Text(
                          'Department',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              departments.map((department) {
                                final isSelected =
                                    _activeFilters['department'] == department;
                                return FilterChip(
                                  label: Text(
                                    department,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setSheetState(() {
                                      if (selected) {
                                        _activeFilters['department'] =
                                            department;
                                      } else {
                                        _activeFilters['department'] = 'All';
                                      }
                                    });
                                    _filterEmployees();
                                  },
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),

                        // Employment Type filter
                        Text(
                          'Employment Type',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              employmentTypes.map((type) {
                                final isSelected =
                                    _activeFilters['employmentType'] == type;
                                return FilterChip(
                                  label: Text(
                                    type,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setSheetState(() {
                                      if (selected) {
                                        _activeFilters['employmentType'] = type;
                                      } else {
                                        _activeFilters['employmentType'] =
                                            'All';
                                      }
                                    });
                                    _filterEmployees();
                                  },
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),

                        // Hire Date Range filter
                        Text(
                          'Hire Date Range',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        _activeFilters['hireDateFrom'] ??
                                        DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setSheetState(() {
                                      _activeFilters['hireDateFrom'] = picked;
                                    });
                                    _filterEmployees();
                                  }
                                },
                                child: Text(
                                  _activeFilters['hireDateFrom'] != null
                                      ? '${_activeFilters['hireDateFrom'].toString().split(' ')[0]}'
                                      : 'From Date',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextButton(
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        _activeFilters['hireDateTo'] ??
                                        DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setSheetState(() {
                                      _activeFilters['hireDateTo'] = picked;
                                    });
                                    _filterEmployees();
                                  }
                                },
                                child: Text(
                                  _activeFilters['hireDateTo'] != null
                                      ? '${_activeFilters['hireDateTo'].toString().split(' ')[0]}'
                                      : 'To Date',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Apply and Clear buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  setSheetState(() {
                                    _activeFilters = {};
                                  });
                                  _filterEmployees();
                                },
                                child: const Text('Clear All'),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Cl.primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Apply Filters'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _navigateToRulesPage() {
    // Get the selected employees
    List<MEmployee> selectedEmployees =
        _allEmployees
            .where((employee) => _selectedEmployeeIds.contains(employee.id))
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EmployeeManagementScreen(employees: selectedEmployees),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Management'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
        actions:
            _isMultiSelectMode
                ? [
                  IconButton(
                    icon: Icon(Icons.check, color: Cl.primaryColor),
                    onPressed:
                        _selectedEmployeeIds.isNotEmpty
                            ? _navigateToRulesPage
                            : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _isMultiSelectMode = false;
                        _selectedEmployeeIds.clear();
                      });
                    },
                  ),
                ]
                : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select employee for choose employee work type, attendance methods and which information\'s an employee can see',
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search employee',
                        suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Cl.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: _showFilterDialog,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          if (_isMultiSelectMode)
            ListTile(
              leading: SizedBox(width: 50.w),
              title: Text(
                "select all",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Cl.primaryColor,
                ),
              ),
              trailing: Checkbox(
                value: _selectedEmployeeIds.length == _filteredEmployees.length,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      // Select all
                      _selectedEmployeeIds =
                          _filteredEmployees.map((e) => e.id).toSet();
                    } else {
                      // Deselect all
                      _selectedEmployeeIds.clear();
                    }
                  });
                },
              ),


            ),
          SizedBox(height: 5.h),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee = _filteredEmployees[index];
                final isSelected = _selectedEmployeeIds.contains(employee.id);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(employee.imageUrl),
                    radius: 22.sp,
                  ),
                  title: Text(
                    employee.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Cl.primaryColor,
                    ),
                  ),
                  trailing:
                      _isMultiSelectMode
                          ? Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              _toggleEmployeeSelection(employee.id);
                            },
                          )
                          : null,
                  selected: isSelected,
                  onTap: () => _onEmployeeTap(employee.id),
                  onLongPress: () => _onEmployeeLongPress(employee.id),
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: _isMultiSelectMode && _selectedEmployeeIds.isNotEmpty
      //     ? FloatingActionButton.extended(
      //   onPressed: _navigateToRulesPage,
      //   label: const Text('Continue'),
      //   icon: const Icon(Icons.arrow_forward),
      // )
      //     : null,
    );
  }
}
