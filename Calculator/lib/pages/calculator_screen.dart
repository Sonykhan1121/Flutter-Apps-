import 'package:calculator_app/provider/button_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculator_body.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final String top = "";
    final String bottom = "";
    return Scaffold(
      body: Consumer<ButtonProvider>(
        builder: (context,value,child){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(

                height: height,
                width: width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),

                  ),

                  elevation: 10.0,
                  shadowColor: Colors.red,
                  color: Color(0xff205b7a),
                  margin: EdgeInsets.symmetric(vertical: 20),


                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 10.0),
                          Image.asset(
                            'assets/tht.png',
                            height: height * 0.1,
                            width: width * 0.2,
                          ),
                          Stack(

                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 2.0),
                                  color: Color(0xffa2bbcf),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.top ,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        value.bottom,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 34.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 20,
                                child: Row(
                                  children: [
                                    Text(
                                      '[D]',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      '[Math]',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Expanded(child: CalculatorBody()),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
