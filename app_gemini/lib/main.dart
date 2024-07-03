import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _promptTextEditController = TextEditingController();

  @override
  void dispose() {
    _promptTextEditController.dispose();
    super.dispose();
  }

  void _sendPrompt() async {
    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: 'api-key'); // Model Settings

    String promptText = _promptTextEditController.text;
    if (promptText.isNotEmpty) {
      final content = [Content.text(promptText)];
      try {
        final response = await model.generateContent(content);
        print(response.text);
      } catch (e) {
        print('Exception: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promptTextEditController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Prompt",
                  ),
                  onChanged: (text) {},
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _sendPrompt,
                child: Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
