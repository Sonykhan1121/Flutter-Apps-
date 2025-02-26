import 'package:codemasterhome/utils/appColors.dart';
import 'package:codemasterhome/utils/appScale.dart';
import 'package:flutter/material.dart';

import 'heading.dart';

class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('37%', 'Learning Progress', context),
              _buildStatCard('12', 'Badges', context),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('45', 'Recent Activity', context),
              _buildStatCard('2h', 'Time Spent', context),
            ],
          ),
          SizedBox(height: 32),

          // Settings Section
          Heading(title: "Profile Settings"),
          SizedBox(height: 16),

          // Dark Mode Switch
          _buildSettingRow(
            'Dark Mode',
            Switch(value: false, onChanged: (value) {}),
          ),

          // Notifications Switch
          _buildSettingRow(
            'Notifications',
            Switch(value: true, onChanged: (value) {}),
          ),

          // Language selection
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: _buildSettingRow('Language', Text('English')),
          ),

          // Support
          _buildSettingRow(
            'Support',
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
              ),
              child: Text(
                "Contact",
                style: TextStyle(
                  fontFamily: "Noto Serif",
                  fontSize: AppScale.scaleText(14, context),
                ),
              ),
            ),
          ),

          SizedBox(height: 32),

          // Log Out Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Implement logout functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: "Noto Serif",
                  color: Colors.white,
                  fontSize: AppScale.scaleText(18, context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build the stat cards
  Widget _buildStatCard(String value, String label, context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: "Noto Serif",
              fontSize: AppScale.scaleText(22, context),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: "Noto Serif",
              color: Colors.blueGrey,
              fontSize: AppScale.scaleText(18, context),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build setting rows
  Widget _buildSettingRow(String label, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontFamily: "Noto Serif")),
          trailing,
        ],
      ),
    );
  }
}
