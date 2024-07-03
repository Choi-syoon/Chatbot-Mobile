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
  final List<Map<String, String>> _messages = []; // 채팅 내역을 저장할 리스트

  @override
  void dispose() {
    _promptTextEditController.dispose();
    super.dispose();
  }

  void _sendPrompt() async {
    final model = GenerativeModel(
        model: 'gemini-pro', apiKey: 'api_key'); // Model Settings

    String promptText = _promptTextEditController.text;
    if (promptText.isNotEmpty) {
      setState(() {
        _messages.add({'user': promptText}); // 사용자의 메시지를 리스트에 추가
      });
      final content = [Content.text(promptText)];
      try {
        final response = await model.generateContent(content);
        setState(() {
          _messages
              .add({'gemini': response.text.toString()}); // Gemini의 응답을 리스트에 추가
        });
      } catch (e) {
        print('Exception: $e');
        setState(() {
          _messages.add({'gemini': 'Error: $e'}); // 오류 메시지를 리스트에 추가
        });
      }
      _promptTextEditController.clear(); // 입력 필드를 초기화
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message.containsKey('user');
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[100] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isUser ? message['user']! : message['gemini']!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
