import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:hungry/views/screens/All_Recipe_Page.dart';
import 'package:hungry/views/screens/page_switcher.dart';
import 'package:hungry/models/message_controller.dart';
import 'package:hungry/views/screens/MyRecipesSection.dart';

class AIChatPage extends StatefulWidget {
  @override
  _AIChatPageState createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Simple Chatbot',
        home: ChatScreen(),
        debugShowCheckedModeBanner: false,
      );
  }
}

class ChatScreen extends StatelessWidget {
  final msgController = TextEditingController();
  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ChatBot'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {

          Navigator.of(context).pop(); // close the dialog

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => PageSwitcher(initialIndex: 0),
            ),
                (route) => false, // remove all previous routes
          );

        },
      ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: controller.messages.length,
              itemBuilder: (_, index) {
                var msg = controller.messages[index];
                return Align(
                  alignment: msg['isUser']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg['isUser'] ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg['text'],
                            style: TextStyle(
                                color: msg['isUser']
                                    ? Colors.white
                                    : Colors.black)),
                        SizedBox(height: 4),
                        Text(msg['time'],
                            style: TextStyle(
                                fontSize: 10,
                                color: msg['isUser']
                                    ? Colors.white70
                                    : Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),
          Obx(() => controller.isTyping.value
              ? Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("Typing...", style: TextStyle(color: Colors.grey)),
          )
              : SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (msgController.text.trim().isNotEmpty) {
                      controller.sendMessage(msgController.text.trim());
                      msgController.clear();
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
