import 'package:codemasterhome/views/practiceview.dart';
import 'package:codemasterhome/views/profileview.dart';
import 'package:codemasterhome/views/testview.dart';
import 'package:flutter/material.dart';

import '../utils/appColors.dart';
import 'homeview.dart';
import 'learnview.dart';

class Root extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5, // Total number of tabs
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height*0.15),
          child: Padding(
            padding: EdgeInsets.only(left:20,top:30,bottom:16,right:20),
            child: AppBar(
              leading: GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: 16,
                  height:16,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Center(
                child: Text('CodeMaster Home', textAlign: TextAlign.center,style: TextStyle(fontFamily: 'NotoSerif',fontSize: 23,fontWeight: FontWeight.w700),),
              ),
              bottom: TabBar(

                tabs: [
                  Tab( text: 'Home'),
                  Tab( text: 'Learn'),
                  Tab( text: 'Practice'),
                  Tab( text: 'Test'),
                  Tab( text: 'Profile'),
                ],
                unselectedLabelColor: AppColors.secondary2,
                labelColor:Colors.black,
                indicatorColor: AppColors.secondary,
                labelStyle: TextStyle(fontFamily: 'NotoSerif',fontSize: 21,fontWeight: FontWeight.w700),
              ),
              actions: [
                IconButton(

                  icon: Icon(Icons.notifications),
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
            TestView(),
            ProfileView(),
          ],
        ),
      ),
    );
  }
}
