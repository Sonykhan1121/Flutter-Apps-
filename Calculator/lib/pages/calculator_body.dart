import 'package:calculator_app/provider/button_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorBody extends StatefulWidget {
  @override
  _CalculatorBodyState createState() => _CalculatorBodyState();
}

class _CalculatorBodyState extends State<CalculatorBody> {



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ButtonProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView.count(
        padding: EdgeInsets.all(0),
        crossAxisCount: 6, // Number of columns
        crossAxisSpacing: 5, // Horizontal space between buttons
        mainAxisSpacing: 5, // Vertical space between buttons
        children: buttons.map((label) =>
            Consumer<ButtonProvider>(
                builder: (context, provider, child) {
                  return CalcButton(label: label, provider: provider);
                }
            )
        ).toList(),
      ),
    );
  }
}

class CalcButton extends StatelessWidget {


  final String label;
  final ButtonProvider provider;

  CalcButton({required this.label, required this.provider});




  @override
  Widget build(BuildContext context) {

    return ElevatedButton(

      
      onPressed: () {
        getOnPress(label,provider);
      },
      child: Text(label,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
      style: ElevatedButton.styleFrom(
        backgroundColor: getButtonColor(label),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Button shape
        )
        // Background color
         // Text color
      ),
    );
  }

  void getOnPress(String label,ButtonProvider provider)  {
    switch (label) {
      case 'ON':
        provider.addButton('Powering on calculator....');

        break;
      case 'HEX':
        print('Switch to HEX mode');
        break;
      case 'DEC':
        print('Switch to DEC mode');
        break;
      case 'OCT':
        print('Switch to OCT mode');
        break;
      case 'BIN':
        print('Switch to BIN mode');
        break;
      case 'sin':
        print('Sin function');
        break;
      case 'cos':
        print('Cos function');
        break;
      case 'tan':
        print('Tan function');
        break;
      case 'log':
        print('Logarithm function');
        break;
      case 'ln':
        print('Natural log function');
        break;
      case 'sin⁻¹':
        print('Inverse sin function');
        break;
      case 'cos⁻¹':
        print('Inverse cos function');
        break;
      case 'tan⁻¹':
        print('Inverse tan function');
        break;
      case '10^x':
        print('10 to the power x function');
        break;
      case 'M+':
        print('Memory add');
        break;
      case 'M-':
        print('Memory subtract');
        break;
      case 'Ans':
        print('Answer');
        break;
      case 'e^':
        print('Exponential function');
        break;
      case 'DEL':
        print('Delete last entry');
        break;
      case 'AC':
        print('All clear');
        provider.clearButton();
        break;
      case '×':
        print('Multiplication');
        break;
      case '÷':
        print('Division');
        break;
      case '+':
        print('Addition');
        break;
      case '-':
        print('Subtraction');
        break;
      case '=':
        print('Calculate result');
        break;
      default:
        print('Undefined button pressed');
        break;
    }
  }

}
Color getButtonColor(String label) {
  if (label == 'AC') {
    return Colors.red;
  } else if (label == '=') {
    return Colors.teal;
  } else if("123456789".contains(label)) {
    return Colors.blue;
  }
  else
  return Colors.blueGrey;
}

// List of button labels as per your grid design
final List<String> buttons =
  ['ON', 'HEX', 'DEC', 'OCT', 'BIN', 'AC',
    'sin', 'cos', 'tan', 'log', 'ln', 'sin⁻¹',
    'cos⁻¹', 'tan⁻¹', '10^x', 'e^', '÷', 'x',
    'Ans', 'DEL', '7', '8', '9', '-',
    'M-', 'M+', '4', '5', '6', '+',
    '.','0', '1', '2', '3', '='];