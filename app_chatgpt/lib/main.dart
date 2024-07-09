import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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

  void _sendPrompt() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("ChatGPT"),
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
                        child: isUser
                            ? Text(
                                message['user']!,
                                style: TextStyle(fontSize: 16),
                              )
                            : MarkdownBody(
                                data: message['gemini']!,
                                styleSheet: MarkdownStyleSheet.fromTheme(
                                  Theme.of(context),
                                ).copyWith(
                                  p: TextStyle(fontSize: 16),
                                ),
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
