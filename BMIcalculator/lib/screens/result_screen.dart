import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultScreen extends StatefulWidget {
   final double bmi;
   final String status;

   ResultScreen({required this.bmi ,required this.status});

   @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text("BMI Gauge",style:theme.titleLarge,)),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 35,),
            Text("Your Current Condition",style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 35,),
            setImagewithBMI(widget.bmi,widget.status),
            SizedBox(height: 15,),
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 16,
                    maximum: 40,
                    startAngle: 180,
                    endAngle: 0,
                    radiusFactor: 0.7,
                    showLabels: true,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(thickness: 50),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.1,
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Text(
                              "BMI = ${widget.bmi}",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      GaugeAnnotation(
                        angle: 185,
                        positionFactor: 1.4,
                        horizontalAlignment: GaugeAlignment.near,
                        widget: const Text("Underweight", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      GaugeAnnotation(
                        angle: 215,
                        positionFactor: 1.2,
                        horizontalAlignment: GaugeAlignment.center,
                        widget: const Text("Normal", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      GaugeAnnotation(
                        angle: 255,
                        positionFactor: 1.2,
                        verticalAlignment: GaugeAlignment.near,
                        horizontalAlignment: GaugeAlignment.near,
                        widget: const Text("Overweight", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      GaugeAnnotation(
                        angle: 310,
                        horizontalAlignment: GaugeAlignment.far,
                        positionFactor: 1.2,
                        widget: const Text("Obesity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      GaugeAnnotation(
                        horizontalAlignment: GaugeAlignment.center,
                        axisValue: 20,
                        angle: 350,
                        positionFactor: 1.2,
                        widget: const Text("Severe Obesity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 16, endValue: 17.5, color: Colors.red, startWidth: 50, endWidth: 50,),
                      GaugeRange(startValue: 17.5, endValue: 25, color: Colors.green, startWidth: 50, endWidth: 50),
                      GaugeRange(startValue: 25, endValue: 30, color: Colors.yellow, startWidth: 50, endWidth: 50),
                      GaugeRange(startValue: 30, endValue: 35, color: Colors.orangeAccent, startWidth: 50, endWidth: 50),
                      GaugeRange(startValue: 35, endValue: 40, color: Colors.red, startWidth: 50, endWidth: 50),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: widget.bmi,
                        enableAnimation: true,
                        needleColor: Colors.black,
                        knobStyle: const KnobStyle(color: Colors.grey, sizeUnit: GaugeSizeUnit.logicalPixel, knobRadius: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Image setImagewithBMI(bmi,status) {
    if (bmi < 17.5) {
      return Image.asset('assets/images/underweight_$status.png');
    } else if (bmi >= 17.5 && bmi < 25) {
      return Image.asset('assets/images/normal_$status.png');
    } else if (bmi >= 25 && bmi < 30) {
      return Image.asset('assets/images/overweight_$status.png');
    } else if (bmi >= 30 && bmi < 35) {
      return Image.asset('assets/images/obesity_$status.png');
    } else {
      return Image.asset('assets/images/severe_obesity.png');
    }
  }
}