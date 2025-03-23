import 'package:flutter/material.dart';

class TestAi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Top Status Bar (Simulated)
                Container(
                  height: 24, // Approximate height
                  color: Colors.grey[800], // Dark gray color
                  child: Center(
                    child: Text(
                      '6:17     78%',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        
                // Profile Picture
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA%3D',
                    height: 150, // Adjust as needed
                    width: double.infinity,
                    fit: BoxFit.scaleDown, // Cover the area without changing aspect ratio
                  ),
                ),
        
                // Personal Information Button
                _buildButton('Personal Information'),
                _buildButton('Academic Qualification'),
                _buildButton('Training Experience'),
                _buildButton('Teaching Area'),
                _buildButton('Research'),
                _buildButton('Award & Scholarship'),
                _buildButton('Previous Employment'),
        
                // Employee Information Card
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mr. Md. Firoz Hasan  Lecturer',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          _buildInfoRow('Name', 'Mr. Md. Firoz Hasan'),
                          _buildInfoRow('Employee ID', '710001985'),
                          _buildInfoRow('Designation', 'Lecturer'),
                          _buildInfoRow(
                              'Department', 'Department of Computer Science and\nEngineering'),
                          _buildInfoRow('Faculty',
                              'Faculty of Science and Information\nTechnology'),
                          _buildInfoRow('Personal Webpage',
                              'https://faculty.daffodilvarsity.edu.bd/prof'),
                          _buildInfoRow('E-mail', 'firoz.cse@diu.edu.bd'),
                          _buildInfoRow('Phone', ''),
                          _buildInfoRow('Cell-Phone', '+8801705726026'),
                        ],
                      ),
                    ),
                  ),
                ),
        
                // Copyright Notice
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Copyright © 2021 Daffodil International University. All Rights\nReserved & Powered by Daffodil Web Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.arrow_back_ios), label: ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}