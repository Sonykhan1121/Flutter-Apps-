  import 'dart:ffi';
import 'dart:math' as math;
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class ButtonProvider extends ChangeNotifier {
  List<String> top = [];
  String bottom = "";
  int count_end_brace = 0;
  String logo_text1  ="D";
  String logo_text2 = "[math]";
  String ans ="";
  List<String> keywords = ['sin(', 'cos(', 'tan(', 'log(', 'ln(', 'sin⁻¹(',
    'cos⁻¹(', 'tan⁻¹(', '10^(', 'e^('];

  void addButton(String buttonText) {
    if(!top.isEmpty&& top[0]=='_')
    {
      top.remove('_');
    }

    top.add(buttonText.toLowerCase());
    if(keywords.contains(buttonText.toLowerCase()))
      {
        count_end_brace++;
      }

    notifyListeners();
  }

  void clearButton() {
    top=['_'];
    bottom='0';
    logo_text2 = "[math]";
    notifyListeners();
  }
  void addresult(String res)
  {

    bottom=(res);
    notifyListeners();
  }
  void addlogotext(String s)
  {
    logo_text2=(s);
    notifyListeners();
  }
  void deleteOne()
  {
    if(top.length>0)
      {
        top.removeLast();
        notifyListeners();
      }
  }

  void calculateResult() {
    while (count_end_brace > 0) {
      top.add(')');
      count_end_brace--;
    }

    if (top.isNotEmpty) {
      String expressionStr = top.join('');
      print('Expression before parsing: $expressionStr');
      try {
        final expression = Expression.parse(expressionStr);
        print("final2 ");
        final evaluator = const ExpressionEvaluator();
        var context = {
          'sin': (num angle) => math.sin(angle * math.pi / 180),
          'cos': (num angle) => math.cos(angle * math.pi / 180),
          'tan': (num angle) => math.tan(angle * math.pi / 180),
          'log': math.log,
          'ln': (num x) => math.log(x)
        }; // Custom context for math functions

        // Evaluate the expression
        final result = evaluator.eval(expression, context);
        ans = result.toString();
        print("result: $result");
        // Update the bottom text with the result
        bottom = "$expressionStr : ${result.toString()}";
        top.clear();
        top.add('_');
      } catch (e) {
        bottom = "Error"; // Handle errors in parsing or evaluation
        print('Error in expression: $e');
      }
    } else {
      bottom = "0";
    }
    notifyListeners();
  }
  void toHexa()
  {
    if(top.isEmpty)
      {
        return ;
      }
    String hexString = int.parse(ans).toRadixString(16);
    bottom = hexString.toUpperCase();
    notifyListeners();

  }
  void toBinary()
  {
    if(top.isEmpty)
    {
      return ;
    }
    String binString = int.parse(ans).toRadixString(2);
    bottom = binString;
    notifyListeners();

  }
  void toOctal()
  {
    if(top.isEmpty)
    {
      return ;
    }
    String ocString = int.parse(ans).toRadixString(8);
    bottom = ocString;
    notifyListeners();

  }
  void toDecimal()
  {
    if(top.isEmpty)
      {
        return;
      }
    bottom = ans.toString();
    notifyListeners();
  }

}
