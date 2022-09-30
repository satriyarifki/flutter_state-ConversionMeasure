import 'package:flutter/foundation.dart';
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
      home: const MyHomePage(title: 'Measure Converter'),
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
  ValueNotifier<double> _result = ValueNotifier<double>(0);

  List<String> listHistory = <String>[];

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

      if (newValue == "inch") {
        result = input * 0.393701;
        _result.value = result;
        if (result != 0) {
          listHistory.add(newValue.toString() + " : " + result.toString());
        }
      } else {
        result = input * 0.0328084;
        _result.value = result;
        if (result != 0) {
          listHistory.add(newValue.toString() + " : " + result.toString());
        }
        
      }
    });
  }

  void makeListHistory() {
    listHistory.add(result.toString());
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
              SizedBox(height: 15,),
              Container(
                  width: 200,
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixText: "cm",
                      suffixStyle: TextStyle(fontSize: 18),
                      hintText: "Insert Number",
                      hintStyle: TextStyle(fontSize: 15),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      dropdownOnChanged();
                    },
                  )),
              SizedBox(height: 15,),
              Container(
                child: Text(
                  "To",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                  child: DropdownButton(
                items: ListItem.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value, style: TextStyle(fontSize: 20)));
                }).toList(),
                value: newValue,
                onChanged: (changeValue) {
                  setState(() {
                    newValue = changeValue.toString();
                  });
                  dropdownOnChanged();
                },
              )),
              SizedBox(height: 15,),
              Container(
                height: 40,
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.lightBlue,
                child: Text(result.toString() + " " + newValue.toString(), style: TextStyle(fontSize: 25, color: Colors.white)),
              ),
              SizedBox(height: 15,),
              Divider(
                color: Colors.blueGrey,
              ),
              SizedBox(height: 20),
              Container(child: Text(" Riwayat Konversi", style: TextStyle(fontSize: 17, ))),
              Container(
                child: ValueListenableBuilder(
                    valueListenable: _result,
                    builder: (context, value, child) {
                      return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: ListView.builder(
                                itemCount: listHistory.length,
                                itemBuilder: (context, index) {
                                  return Text(listHistory[index], style: TextStyle(fontSize: 17),);
                                }),
                          ));
                    }),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
