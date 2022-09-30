import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double input = 0;
  double cm = 0;
  double reamur = 0;
  final inputController = TextEditingController();
  String newValue = "inch";
  double result = 0;

  var ListItem = [
    'inch',
    'feet',
  ];

  external static double? tryParse(String inputController);

  void dropdownOnChanged() {
    setState(() {
      if (inputController.text == "") {
        input = double.parse("0");
      } else {
        input = double.parse(inputController.text);
      }

      if (newValue == "inch")
        result = input * 0.393701;
      else
        result = input * 0.0328084;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  width: 200,
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      dropdownOnChanged();
                    },
                  )),
              Container(
                  child: DropdownButton(
                items: ListItem.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                value: newValue,
                onChanged: (changeValue) {
                  setState(() {
                    newValue = changeValue.toString();
                  });
                  dropdownOnChanged();
                },
              )),
              Container(
                child: Text(result.toString()),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
