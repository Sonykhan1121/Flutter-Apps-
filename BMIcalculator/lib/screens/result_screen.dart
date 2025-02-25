import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Gauge")),
      body: Center(
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
                    children: const [
                      Text(
                        "BMI = 20.1",
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
                  horizontalAlignment: GaugeAlignment.far,
                  axisValue: 20,
                  angle: 350,
                  positionFactor: 1.2,
                  widget: const Text("Severe Obesity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
              ranges: <GaugeRange>[
                GaugeRange(startValue: 16, endValue: 17.5, color: Colors.red, startWidth: 50, endWidth: 50,labelStyle: TextStyle(fontSize: 16),),
                GaugeRange(startValue: 17.5, endValue: 25, color: Colors.green, startWidth: 50, endWidth: 50),
                GaugeRange(startValue: 25, endValue: 30, color: Colors.yellow, startWidth: 50, endWidth: 50),
                GaugeRange(startValue: 30, endValue: 35, color: Colors.orangeAccent, startWidth: 50, endWidth: 50),
                GaugeRange(startValue: 35, endValue: 40, color: Colors.red, startWidth: 50, endWidth: 50),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: 20.1,
                  enableAnimation: true,
                  needleColor: Colors.black,
                  knobStyle: const KnobStyle(color: Colors.grey, sizeUnit: GaugeSizeUnit.logicalPixel, knobRadius: 5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}