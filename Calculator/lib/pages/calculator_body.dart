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

  Future<void> getOnPress(String label,ButtonProvider provider)  async {
    switch (label) {
      case 'ON':
        provider.clearButton();
        provider.addButton('Powering on calculator....');
        await Future.delayed(Duration(seconds: 1));
        provider.clearButton();
        break;
      case 'HEX':
        print('Switch to HEX mode');
        provider.addlogotext('[HEX]');
        provider.toHexa();
        break;
      case 'DEC':
        print('Switch to DEC mode');
        provider.addlogotext('[DEC]');
        provider.toDecimal();

        break;
      case 'OCT':
        print('Switch to OCT mode');
        provider.addlogotext('[OCT]');
        provider.toOctal();
        break;
      case 'BIN':
        print('Switch to BIN mode');
        provider.addlogotext('[BIN]');
        provider.toBinary();
        break;
      case 'sin':
        print('Sin function');
        provider.addButton("Sin(");
        break;
      case 'cos':
        print('Cos function');
        provider.addButton('Cos(');
        break;
      case 'tan':
        print('Tan function');
        provider.addButton('tan(');
        break;
      case 'log':
        print('Logarithm function');
        provider.addButton('Log(');
        break;
      case 'ln':
        print('Natural log function');
        provider.addButton('Ln(');
        break;
      case 'sin⁻¹':
        print('Inverse sin function');
        provider.addButton('sin⁻¹(');
        break;
      case 'cos⁻¹':
        print('Inverse cos function');
        provider.addButton('cos⁻¹(');
        break;
      case 'tan⁻¹':
        print('Inverse tan function');
        provider.addButton('tan⁻¹(');
        break;
      case '10^x':
        print('10 to the power x function');
        provider.addButton('10^(');
        break;
      case 'M+':
        print('Memory add');
        break;
      case 'M-':
        print('Memory subtract');
        break;
      case 'Ans':
        print('Answer');
        provider.addButton(" ${provider.ans}");
        break;
      case 'e^':
        print('Exponential function');
        provider.addButton('e^(');
        break;
      case 'DEL':
        print('Delete last entry');

        provider.deleteOne();
        break;
      case 'AC':
        print('All clear');
        provider.clearButton();
        break;
      case 'x':
        print('Multiplication');
        provider.addButton('*');
        break;
      case '÷':
        print('Division');
        provider.addButton('/');
        break;
      case '+':
        print('Addition');
        provider.addButton("+");
        break;
      case '-':
        print('Subtraction');
        provider.addButton("-");
        break;
      case '=':
        print('Calculate result');
        provider.calculateResult();
        break;
      case "1":
        provider.addButton("1");
        break;
      case "2":
        provider.addButton("2");
        break;
      case "3":
        provider.addButton("3");
        break;
      case "4":
        provider.addButton("4");
        break;
      case "5":
        provider.addButton("5");
        break;
      case "6":
        provider.addButton("6");
        break;
      case "7":
        provider.addButton("7");
        break;
      case "8":
        provider.addButton("8");
        break;
      case "9":
        provider.addButton("9");
        break;
      case "0":
        provider.addButton("0");
        break;
      case '.':
        provider.addButton(".");
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