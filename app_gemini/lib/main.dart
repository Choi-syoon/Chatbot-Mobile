import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget{
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>{

  final _promptTextEditController = TextEditingController();

  @override
  void dispose() {
    _promptTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Gemini"),
      ),
      body: Center(
        child: Column(),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _promptTextEditController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelText: "Prompt",
          ),
          onChanged: (text) {
            print(text);
          },
        ),
      )
      )
    );
  }
}