import 'package:bmicalculator/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedGender;
  String _heightUnit = 'cm';
  String _weightUnit = 'kg';
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController1 = TextEditingController();
  final TextEditingController _heightController2 = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  List<Widget> _buildHeightFields() {
    if (_heightUnit == 'feet') {
      return [
        Flexible(
          child: TextFormField(
            controller: _heightController1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Feet'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Enter feet';
              return null;
            },
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: TextFormField(
            controller: _heightController2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Inches'),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Enter inches';
              return null;
            },
          ),
        ),
      ];
    }
    return [
      Flexible(
        child: TextFormField(
          controller: _heightController1,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: _heightUnit == 'cm' ? 'Centimeters' : 'Meters',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Enter height';
            return null;
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // BMI Logo
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Center(
                  child: Text(
                    'BMI',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Age Input
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,

                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

                ],
                decoration: InputDecoration(
                  labelText: 'Age',
                  suffixText: 'Ages 2-120',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter age';
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Gender Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('Male'),
                          value: 'male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Female'),
                          value: 'female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  if (_selectedGender != null)
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/${_selectedGender}.png',
                        width: 200,
                        height: 100,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),

              // Height Input
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _heightUnit,
                    items: [
                      DropdownMenuItem(
                        value: 'cm',
                        child: Row(
                          children: [
                            Icon(Icons.straighten), // Icon for centimeters
                            SizedBox(width: 8),
                            Text('CM'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'm',
                        child: Row(
                          children: [
                            Icon(Icons.height), // Icon for meters
                            SizedBox(width: 8),
                            Text('M'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'feet',
                        child: Row(
                          children: [
                            Icon(Icons.accessibility), // Icon for feet (using accessibility as a placeholder)
                            SizedBox(width: 8),
                            Text('FEET'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _heightUnit = value!;
                        _heightController1.clear();
                        _heightController2.clear();
                      });
                    },
                  ),
                  Row(children: _buildHeightFields()),
                ],
              ),
              SizedBox(height: 20),

              // Weight Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _weightUnit,
                    items: ['kg', 'pounds']
                        .map((unit) => DropdownMenuItem(
                      value: unit,
                      child: Text(unit),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _weightUnit = value!);
                    },
                  ),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: _weightUnit == 'kg'
                          ? 'Enter weight in kilograms'
                          : 'Enter weight in pounds',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Enter weight';
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(),
                          ),
                        );
                      }
                    },
                    child: Text('Calculate'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      _ageController.clear();
                      _heightController1.clear();
                      _heightController2.clear();
                      _weightController.clear();
                      setState(() {
                        _selectedGender = null;
                        _heightUnit = 'cm';
                        _weightUnit = 'kg';
                      });
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



