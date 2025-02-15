import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class AddTaskPage extends StatefulWidget {
  final Task? existingTask;

  AddTaskPage({this.existingTask});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;
  late int _priority;
  late String _category;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTask?.title ?? '');
    _descriptionController = TextEditingController(text: widget.existingTask?.description ?? '');
    _dueDateController = TextEditingController(text: widget.existingTask?.dueDate ?? '');
    _priority = widget.existingTask?.priority ?? 1;
    _category = widget.existingTask?.category ?? 'General';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingTask == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple, // Vibrant app bar color
        elevation: 10, // Add shadow for depth
        iconTheme: IconThemeData(color: Colors.white), // White back icon
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _buildInputField(
                  controller: _titleController,
                  label: 'Title',
                  icon: Icons.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  controller: _descriptionController,
                  label: 'Description',
                  icon: Icons.description,
                ),
                SizedBox(height: 16),
                _buildDatePickerField(),
                SizedBox(height: 16),
                _buildPriorityDropdown(),
                SizedBox(height: 16),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePickerField() {
    return TextFormField(
      controller: _dueDateController,
      decoration: InputDecoration(
        labelText: 'Due Date',
        prefixIcon: Icon(Icons.calendar_today, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard from showing
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _dueDateController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(_dueDateController.text) : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          _dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate); // Ensure you import 'package:intl/intl.dart';
        }
      },
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<int>(
      value: _priority,
      items: [
        DropdownMenuItem(child: Text("Low"), value: 1),
        DropdownMenuItem(child: Text("Medium"), value: 2),
        DropdownMenuItem(child: Text("High"), value: 3),
      ],
      onChanged: (int? newValue) {
        setState(() {
          _priority = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Priority',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple, // Button color
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Save Task',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Remove manual ID assignment
      Task task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        dueDate: _dueDateController.text,
        priority: _priority,
        category: _category,
      );

      if (widget.existingTask == null) {
        Provider.of<TaskProvider>(context, listen: false).addTask(task);
      } else {
        // For existing tasks, keep the original ID
        task = task.copyWith(id: widget.existingTask!.id);
        Provider.of<TaskProvider>(context, listen: false).updateTask(task);
      }

      Navigator.of(context).pop();
    }
  }
}