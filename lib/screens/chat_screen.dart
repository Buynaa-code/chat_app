import 'package:chat_app/utilies/not.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  // Серверт холбогдох функц
  void connectToServer() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Зурвас хүлээн авах
    socket.on('receiveMessage', (data) {
      setState(() {
        messages.add(data);
      });

      // Мэдэгдэл харуулах
      showNotification(data);
    });
  }

  // Зурвас илгээх функц
  void sendMessage(String message) {
    socket.emit('sendMessage', message);
    setState(() {
      messages.add("Та: $message");
    });
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат Програм', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSentByMe = messages[index].startsWith("Та:");
                return Align(
                  alignment:
                      isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      messages[index],
                      style: TextStyle(
                        color: isSentByMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Зурвас бичих...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        sendMessage(messageController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
