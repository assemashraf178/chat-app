import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:chat_app/layouts/home_layout.dart';
import 'package:chat_app/modules/login/login_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorLayout extends StatefulWidget {
  const CalculatorLayout({Key? key}) : super(key: key);

  @override
  _CalculatorLayoutState createState() => _CalculatorLayoutState();
}

class _CalculatorLayoutState extends State<CalculatorLayout> {
  late Widget startWidget;

  String equation = '0';

  String expression = '';

  String result = '0';

  bool isOperation = false;

  bool isPoint = false;

  bool isNumber = false;

  double equationFontSize = 15.0;

  double resultFontSize = 18.0;

  Color equationColor = Colors.black;

  Color resultColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    if (uId == null) {
      startWidget = LoginScreen();
    } else {
      startWidget = HomeLayout();
    }
  }

  Widget buildButton({
    required BuildContext context,
    required String text,
    Color color = Colors.black,
    double? fontSize,
  }) =>
      Container(
        child: MaterialButton(
          onPressed: () {
            setState(() {
              if (text == '⌫') {
                if (equation != '0')
                  equation = equation.substring(0, equation.length - 1);
                if (isOperation) isOperation = false;
                if (isPoint && !isNumber) isPoint = false;
                if (equation == '') {
                  isPoint = false;
                  isOperation = false;
                  isNumber = false;
                }
                equationFontSize = 15.0;
                resultFontSize = 18.0;
                equationColor = Colors.black;
                resultColor = Colors.grey;
              } else if (text == 'C') {
                equationFontSize = 15.0;
                resultFontSize = 18.0;
                equation = '0';
                result = '0';
                equationColor = Colors.black;
                resultColor = Colors.grey;
              } else if (text == '=') {
                expression = equation;
                isPoint = true;
                isOperation = false;
                equationFontSize = 18.0;
                resultFontSize = 15.0;
                equationColor = Colors.grey;
                resultColor = Colors.black;
                expression = expression.replaceAll('×', '*');
                expression = expression.replaceAll('÷', '/');
                expression = expression.replaceAll('−', '-');
                try {
                  Parser p = Parser();
                  Expression exp = p.parse(expression);
                  ContextModel cm = ContextModel();
                  result = '${exp.evaluate(EvaluationType.REAL, cm)}';
                  equation = result;
                } catch (e) {
                  print(e.toString());
                  result = 'Error';
                }
              } else {
                if (equation == '0') {
                  equation = '';
                }
                if ((text == '+' ||
                        text == '÷' ||
                        text == '×' ||
                        text == '%' ||
                        text == '−') &&
                    equation != '0' &&
                    equation != '') {
                  if (!isOperation) {
                    print(isOperation);
                    isOperation = true;
                    isPoint = false;
                    isNumber = false;
                    equation += text;
                    equationFontSize = 15.0;
                    resultFontSize = 18.0;
                    equationColor = Colors.black;
                    resultColor = Colors.grey;
                  }
                } else if (text == '.') {
                  if (!isPoint) {
                    isPoint = true;
                    isNumber = false;
                    equation += text;
                  } else if (equation == '') isPoint = false;
                } else {
                  isOperation = false;
                  isNumber = true;
                  equation += text;
                  equationFontSize = 15.0;
                  resultFontSize = 18.0;
                  equationColor = Colors.black;
                  resultColor = Colors.grey;
                }
              }
            });
          },
          height: double.infinity,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: color,
                  fontSize:
                      fontSize ?? MediaQuery.of(context).size.height / 25.0,
                ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        title: Row(
          children: [
            Spacer(),
            InkWell(
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => startWidget),
                );
              },
              child: Icon(
                Icons.calculate_rounded,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 30.0,
            ),
            Text(
              'Calculator',
            ),
            Spacer(),
          ],
        ),
        context: context,
        leading: false,
        titleColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width) / 40),
                    alignment: Alignment.bottomRight,
                    child: AutoSizeText(
                      equation,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height /
                            equationFontSize,
                        color: equationColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width) / 40),
                    alignment: Alignment.topRight,
                    child: AutoSizeText(
                      result,
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.height / resultFontSize,
                        color: resultColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.teal.withOpacity(0.05),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: 'C',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '%',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '⌫',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '÷',
                            context: context,
                            color: Colors.lightBlueAccent,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '7',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '8',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '9',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '×',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '4',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '5',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '6',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '−',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '1',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '2',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '3',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '+',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: buildButton(
                            text: '00',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '0',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '.',
                            context: context,
                          ),
                        ),
                        Expanded(
                          child: buildButton(
                            text: '=',
                            context: context,
                            fontSize: MediaQuery.of(context).size.height / 16.0,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
