import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/message_model.dart';
import '../services/speech_recognition_service.dart';
import '../services/text_to_speech_service.dart';
import '../services/chat_gpt_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<MessageModel> _messages = [];
  bool _isLoading = false;

  void _sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(MessageModel(text: text, type: MessageType.user));
      _isLoading = true;
    });

    try {
      final chatGPTService = Provider.of<ChatGPTService>(context, listen: false);
      final ttsService = Provider.of<TextToSpeechService>(context, listen: false);

      final response = await chatGPTService.generateResponse(_messages);
      
      setState(() {
        _messages.add(MessageModel(text: response, type: MessageType.bot));
        _isLoading = false;
      });

      await ttsService.speak(response);
    } catch (e) {
      setState(() {
        _messages.add(MessageModel(
          text: 'Sorry, an error occurred.',
          type: MessageType.bot
        ));
        _isLoading = false;
      });
    }
  }

  void _listenToSpeech() async {
    final speechService = Provider.of<SpeechRecognitionService>(context, listen: false);
    
    try {
      await speechService.initialize();
      final recognizedText = await speechService.startListening();
      
      if (recognizedText != null && recognizedText.isNotEmpty) {
        _sendMessage(recognizedText);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition error'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Practice'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          
          if (_isLoading)
            SpinKitThreeBounce(color: Colors.blue, size: 30),
          
          _buildMessageInputArea(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listenToSpeech,
        backgroundColor: Colors.blue,
        child: Icon(Icons.mic),
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _sendMessage(_textController.text);
                _textController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}