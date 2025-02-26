import 'package:codemasterhome/views/practiceview.dart';
import 'package:codemasterhome/views/profileview.dart';
import 'package:codemasterhome/views/testview.dart';
import 'package:flutter/material.dart';

import '../utils/appColors.dart';
import '../utils/appScale.dart';
import '../widgets/test_taking.dart';
import 'homeview.dart';
import 'learnview.dart';

class Root extends StatefulWidget {
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5, // Total number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.15),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 30, bottom: 16, right: 20),
            child: AppBar(
              leading: GestureDetector(
                onTap: () {},
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 32.0,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/tht.png',
                        fit: BoxFit.scaleDown, // Or BoxFit.contain
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
              title: Center(
                child: Text(
                  'CodeMaster Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NotoSerif',
                    fontSize: AppScale.scaleText(18, context),
                    fontWeight: FontWeight.w700,

                  ),
                  textScaler: MediaQuery.of(context).textScaler,
                ),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Learn'),
                  Tab(text: 'Practice'),
                  Tab(text: 'Test'),
                  Tab(text: 'Profile'),
                ],
                unselectedLabelColor: AppColors.secondary2,
                labelColor: Colors.black,
                indicatorColor: AppColors.secondary,
                labelStyle: TextStyle(
                  fontFamily: 'NotoSerif',
                  fontSize: AppScale.scaleText(16, context),
                  fontWeight: FontWeight.w700,
                ),
                  textScaler: MediaQuery.of(context).textScaler
              ),
              actions: [
                IconButton(

                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Handle search action
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            HomeView(),
            LearnView(),
            PracticeView(),
            TestScreen(),
            ProfileView(),
          ],
        ),
      ),
    );
  }
}
