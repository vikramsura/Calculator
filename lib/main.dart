

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const My(),
    );
  }
}

class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  var firstNum = 0.0;
  var secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  onButtonClick(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == 'X') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        // input = output;
      }
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calculator'),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 30, color: Colors.black,fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 30),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: 40, color: Colors.black,fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              button(text: "C", bColor: Colors.deepOrangeAccent,),
              button(text: "X", bColor: Colors.deepOrangeAccent,),
              button(text: '.',  bColor: Colors.black54,),
              button(text: "/",  bColor: Colors.black54,),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: '3'),
              button(text: "*", bColor: Colors.black54,),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: '6'),
              button(text: "-",  bColor: Colors.black54,),
            ],
          ),
          Row(
            children: [
              button(text: "7",),
              button(text: "8"),
              button(text: '9'),
              button(text: "+",  bColor: Colors.black54,),
            ],
          ),
          Row(
            children: [
              button(text: "0"),
              button(text: "00"),
              button(
                text: "=",
                bColor: Colors.black54,
              ),
            ],
          )
        ]));
  }

  Widget button({text, tColor, bColor,}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            onButtonClick(text);
          },
          child: Center(
              child: Text(
                "$text",
                style: TextStyle(
                    color: tColor, fontWeight: FontWeight.w900, fontSize: 24.0),
              )),
          style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(side: BorderSide(color: Colors.black54,strokeAlign: 5),
                  borderRadius: BorderRadius.circular(2)),
              primary: bColor),
        ),
      ),
    );
  }
}
