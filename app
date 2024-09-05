import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _input = "";
  String _operand = "";
  double _num1 = 0;
  double _num2 = 0;
  bool _isResultDisplayed = false;

  void buttonPressed(String buttonText) {
    setState(() {
      try {
        if (buttonText == "C") {
          _input = "";
          _num1 = 0;
          _num2 = 0;
          _operand = "";
          _output = "0";
          _isResultDisplayed = false;
        } else if (buttonText == "⌫") {
          if (_input.isNotEmpty && !_isResultDisplayed) {
            _input = _input.substring(0, _input.length - 1);
            _output = _input.isEmpty ? "0" : _input;
          }
        } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
          if (_input.isNotEmpty && !_isResultDisplayed) {
            _num1 = double.parse(_input);
            _operand = buttonText;
            _input = "";
          } else if (_isResultDisplayed) {
            _num1 = double.parse(_output);
            _operand = buttonText;
            _input = "";
            _isResultDisplayed = false;
          }
        } else if (buttonText == ".") {
          if (!_input.contains(".")) {
            _input += buttonText;
          }
        } else if (buttonText == "=") {
          if (_input.isNotEmpty && _operand.isNotEmpty) {
            _num2 = double.parse(_input);

            switch (_operand) {
              case "+":
                _output = (_num1 + _num2).toString();
                break;
              case "-":
                _output = (_num1 - _num2).toString();
                break;
              case "*":
                _output = (_num1 * _num2).toString();
                break;
              case "/":
                _output = _num2 == 0 ? "Cannot divide by zero" : (_num1 / _num2).toString();
                break;
            }
            _input = "";
            _operand = "";
            _isResultDisplayed = true;
          }
        } else {
          if (_isResultDisplayed) {
            _input = buttonText;
            _isResultDisplayed = false;
          } else {
            _input += buttonText;
          }
        }

        if (!_isResultDisplayed) {
          _output = _input.isEmpty ? "0" : _input;
        }
      } catch (e) {
        _output = "0"; // Reset output on error
      }
    });
  }

  Widget buildButton(String buttonText, {Color color = Colors.grey}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator App'), // Updated title
        backgroundColor: Colors.blueGrey[900],
        elevation: 0, // Remove shadow/elevation from the AppBar to remove strap
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              _isResultDisplayed ? '' : '$_num1 $_operand $_input',
              style: TextStyle(fontSize: 24.0, color: Colors.grey[400]),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.grey),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7", color: Colors.grey[700]!),
                  buildButton("8", color: Colors.grey[700]!),
                  buildButton("9", color: Colors.grey[700]!),
                  buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", color: Colors.grey[700]!),
                  buildButton("5", color: Colors.grey[700]!),
                  buildButton("6", color: Colors.grey[700]!),
                  buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", color: Colors.grey[700]!),
                  buildButton("2", color: Colors.grey[700]!),
                  buildButton("3", color: Colors.grey[700]!),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton(".", color: Colors.blueGrey[700]!),
                  buildButton("0", color: Colors.grey[700]!),
                  buildButton("00", color: Colors.grey[700]!),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("C", color: Colors.blueAccent),   // Consistent color for "C"
                  buildButton("⌫", color: Colors.blueAccent),   // Consistent color for "Back"
                  buildButton("=", color: Colors.blueAccent),   // Consistent color for "="
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}