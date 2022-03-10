import 'package:calculatorapp/ui/Calculator_History/Model/historyitem.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

import 'Calculator_History/history.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = " ";
  String result = "0";
  String expression = " ";
  double equationFontSize = 25;
  double resultFontSize = 30;
  String history = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = " ";
        result = "0";
        equationFontSize = 30;
        resultFontSize = 35;
      } else if (buttonText == "⌫") {
        equationFontSize = 30;
        resultFontSize = 35;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "0") {
          equation = "0";
        }
      } else if (buttonText == "⌫") {
        equationFontSize = 30;
        resultFontSize = 35;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 25;
        resultFontSize = 30;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          String result1 = '${exp.evaluate(EvaluationType.REAL, cm)}';
          double dtos = double.parse(result1);
          //value round double
          double result2 = double.parse(dtos.toStringAsFixed(3));
          //.0 remove
          RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
          result = result2.toString().replaceAll(regex, '');
        } catch (e) {
          result = "Error";
        }
        //add calculation in history
        final historyItem = HistoryItem()
          ..title = result
          ..subtitle = equation;
        Hive.box<HistoryItem>('history').add(historyItem);
      } else {
        equationFontSize = 30;
        resultFontSize = 25;

        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
      if (equation.length > 18) {
        equationFontSize = 20;
      }
    });
  }

  //Numbers Button
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: InkWell(
        onTap: () => buttonPressed(buttonText),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.black26,
                      offset: Offset(0, 3))
                ]),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.indigo),
            )),
      ),
    );
  }

  //Calc Button
  Widget buildCalcButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      color: buttonColor,
      child: InkWell(
        onTap: () => buttonPressed(buttonText),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.black26,
                      offset: Offset(0, 3))
                ]),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.indigo),
            )),
      ),
    );
  }

  //== Button
  Widget buildequlButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      margin: const EdgeInsets.all(10),
      color: buttonColor,
      child: InkWell(
        onTap: () => buttonPressed(buttonText),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.black26,
                      offset: Offset(0, 3))
                ]),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.indigo),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => History()));
              },
              child: const Icon(
                Icons.history,
                color: Colors.indigo,
              )),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //Calculation
          Container(
            padding: const EdgeInsets.only(left: 30),
            height: MediaQuery.of(context).size.height * .15,
            alignment: Alignment.bottomRight,
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              reverse: true,
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: _editTitleTextField(),
              ),
            ),
          ),

          //Result
          Container(
            height: 70,
            alignment: Alignment.centerRight,
            child: FittedBox(
              clipBehavior: Clip.none,
              fit: BoxFit.fitHeight,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: resultFontSize,
                  ),
                ),
              ),
            ),
          ),

          //Buttons
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildCalcButton("C", 1, Colors.white),
                        buildCalcButton("⌫", 1, Colors.white),
                        buildCalcButton("÷", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.white),
                        buildButton("8", 1, Colors.white),
                        buildButton("9", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.white),
                        buildButton("5", 1, Colors.white),
                        buildButton("6", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.white),
                        buildButton("2", 1, Colors.white),
                        buildButton("3", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildButton("0", 1, Colors.white),
                        buildButton("00", 1, Colors.white),
                        buildButton(".", 1, Colors.white),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildCalcButton("×", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildCalcButton("-", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildCalcButton("+", 1, Colors.white),
                      ]),
                      TableRow(children: [
                        buildequlButton("=", 2, Colors.white),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _editTitleTextField() {
    return Text(
      equation,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: equationFontSize,
      ),
    );
  }
}
