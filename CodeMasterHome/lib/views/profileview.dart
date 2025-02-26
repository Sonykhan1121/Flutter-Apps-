import 'package:codemasterhome/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProfileWidget(),
      ),
    );
  }
}
