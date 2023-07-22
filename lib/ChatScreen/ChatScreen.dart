import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String myUserId;
  final String otherUserId;
  final String name;


  ChatScreen({required this.myUserId, required this.otherUserId, required this.name,});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();
  bool isConnected = false;
  String roomId=" ";
  late IO.Socket socket;
  int _page = 1;
  bool _isLoading = false;
  List<Map<String, String>> _messages = [];
  final _scrollController = ScrollController();

  String _lastMessageId = '';

  Future<void> _loadMessages() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await http.get(
          Uri.parse('http://192.168.0.172:3000/messages/${widget.myUserId}/${widget.otherUserId}/$_page/?lastMessageId=$_lastMessageId'),
          headers: {"Content-Type": "application/json"},
        );
        final data = jsonDecode(response.body);
        final List<Map<String, dynamic>> messages =
        List<Map<String, dynamic>>.from(data['messages']);

        // Check if we received any new messages
        if (messages.isNotEmpty) {
          // Update the last message ID to the ID of the last message in the list


          setState(() {
            _messages.addAll(messages.map((message) {
              return Map<String, String>.from(message.map(
                    (key, value) => MapEntry(key, value.toString()),
              ));
            }).where((message) => !_messages.any((existingMessage) => existingMessage['_id'] == message['_id'])));
            _messages.sort((a, b) => b['createdAt']!.compareTo(a['createdAt'].toString()));
            _lastMessageId = messages.last['_id'];
            _isLoading = false;
          });
        } else {
          // If we didn't receive any new messages, stop loading more messages
          setState(() {
            _lastMessageId = messages.last['_id'];
            _isLoading = false;
            _page++;
          });
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void connectToServer() {
    try {
      // Configure socket transports must be specified
      socket = IO.io('http://192.168.0.172:3000/',IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
      socket.connect();

    } catch (e) {
      // print("hello");
      print(e.toString());
    }
  }
  @override
  void initState() {
    super.initState();
    connectToServer();
    _loadMessages();
    _scrollController.addListener(_scrollListener);
    if (widget.myUserId.compareTo(widget.otherUserId) < 0) {
      roomId = '${widget.myUserId}${widget.otherUserId}';
    } else {
      roomId = '${widget.otherUserId}${widget.myUserId}';
    }
    socket.emit('join', roomId );
    socket.onConnect((data) {
      print('Connected to socket');
      isConnected = true;
    });
    socket.onDisconnect((data) {
      print('Disconnected from socket');
      isConnected = false;
    });
    socket.on('message', _handleIncomingMessage);
  }
  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMessages();
    }
  }

  @override
  void dispose() {
    socket.off('message', _handleIncomingMessage);
    super.dispose();
  }

  void _handleIncomingMessage(data) {
    // print("Coming:${data}");
    setState(() {
      Map<String, String> message = {
        'senderId': data['senderId'],
        'receiverId': data['receiverId'],
        'text': data['text'].toString(),
      };
      // print(message);
      if(message['senderId']!=widget.myUserId){
        _messages.insert(0, message);
      }
    });
  }

  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty&&isConnected==true) {
      Map<String, String> message = {
        'senderId': widget.myUserId,
        'receiverId': widget.otherUserId,
        'text': text,
        'roomId':roomId
      };
      // print("hellll${message}");
      socket.emit('message', message);
      setState(() {
        // Add the new message to the beginning of the list
        _messages.insert(0, message);
      });

      _messageController.clear();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          SizedBox(
            height: 60,
            child: Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffF89F5B),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(1.0, 2.0))
                        ]),
                    height: 30,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                height: 20,
                                width: 20,
                                child: const Icon(Icons.arrow_back,color: Colors.black,)),
                          ),
                          Text(
                            widget.name,
                            style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 6),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/profile.png")),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff2F62BB),
                          blurRadius: 2,
                        )
                      ]),
                  height: 50,
                  width: 50,
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                Map<String, String> message = _messages[index];
                bool isMyMessage = message['senderId'].toString()== widget.myUserId;
                final alignment = isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start;
                final messageColor = isMyMessage ? Colors.black : Colors.white;
                return Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              isMyMessage?Container():Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/pic.jpg")),
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff2F62BB),
                                        blurRadius: 2,
                                      )
                                    ]),
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isMyMessage?const Color(0xffE2E2E2):const Color(0xff9C3587),
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                    ),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${_messages[index]['text']}",
                                          maxLines: 8, // Change this value as needed
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12, color: messageColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,)
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1.0, 2.0))
                  ]),
              height: 50,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 17, left: 10),
                        border: InputBorder.none,
                        hintText: "Type your message ",
                        hintStyle:
                        const TextStyle(fontSize: 15, color: Color(0xff97AABD)),
                        suffixIcon: IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send),

                        )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}