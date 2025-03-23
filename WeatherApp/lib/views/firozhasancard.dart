import 'package:flutter/material.dart';

class Firozhasancard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lecturer Profile'),
        ),
        body: LecturerProfile(),
      ),
    );
  }
}

class LecturerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mr. Md. Firoz Hasan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Lecturer',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
          Divider(),
          ProfileDetail(label: 'Name', value: 'Mr. Md. Firoz Hasan'),
          ProfileDetail(label: 'Employee ID', value: '7100001985'),
          ProfileDetail(label: 'Designation', value: 'Lecturer'),
          ProfileDetail(label: 'Department', value: 'Department of Computer Science and Engineering'),
          ProfileDetail(label: 'Faculty', value: 'Faculty of Science and Information Technology'),
          ProfileDetail(label: 'Personal Webpage', value: 'https://faculty.daffodilvarsity.edu.bd/prof'),
          ProfileDetail(label: 'E-mail', value: 'firoz.cse@diu.edu.bd'),
          ProfileDetail(label: 'Phone', value: 'N/A'),
          ProfileDetail(label: 'Cell-Phone', value: '+8801705726026'),
        ],
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  ProfileDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}