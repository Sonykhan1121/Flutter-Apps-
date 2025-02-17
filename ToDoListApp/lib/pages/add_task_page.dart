import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingTask == null ? AppLocalizations.of(context)!.addTask : AppLocalizations.of(context)!.editTask,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeData.appBarTheme.titleTextStyle?.color,
          ),
        ),
        backgroundColor: themeData.appBarTheme.backgroundColor,
        elevation: 10,
        iconTheme: themeData.appBarTheme.iconTheme,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [themeData.colorScheme.primary.withOpacity(0.05),
              themeData.scaffoldBackgroundColor],
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
                  label: AppLocalizations.of(context)!.title,
                  icon: Icons.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.enterTitle;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildInputField(
                  controller: _descriptionController,
                  label: AppLocalizations.of(context)!.description,
                  icon: Icons.description,
                ),
                SizedBox(height: 16),
                _buildDatePickerField(),
                SizedBox(height: 16),
                _buildPriorityDropdown(),
                SizedBox(height: 16),
                _buildCategoryDropdown(),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themeData = themeProvider.themeData;
    return TextFormField(
      controller: controller,
      maxLines: 1,
      style: TextStyle(color: themeData.colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: themeData.colorScheme.onSurface),
        prefixIcon: Icon(icon, color: themeData.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePickerField() {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
    return TextFormField(
      controller: _dueDateController,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.dueDate,
        labelStyle: TextStyle(color: themeData.colorScheme.onSurface),
        prefixIcon: Icon(Icons.calendar_today, color: themeData.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary, width: 2),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _dueDateController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(_dueDateController.text) : DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          _dueDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
    );
  }

  Widget _buildPriorityDropdown() {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
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
        labelText: AppLocalizations.of(context)!.priority,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
    return DropdownButtonFormField<String>(
      value: _category,
      items: [
        DropdownMenuItem(child: Text("General"), value: 'General'),
        DropdownMenuItem(child: Text("Work"), value: 'Work'),
        DropdownMenuItem(child: Text("Personal"), value: 'Personal'),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _category = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.category,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: themeData.colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    final themeData = Provider.of<ThemeProvider>(context).themeData;
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: themeData.colorScheme.primary,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        AppLocalizations.of(context)!.saveTask,
        style: TextStyle(
          fontSize: 18,
          color: themeData.colorScheme.onPrimary,
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
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
        task = task.copyWith(id: widget.existingTask!.id);
        Provider.of<TaskProvider>(context, listen: false).updateTask(task);
      }

      Navigator.of(context).pop();
    }
  }
}