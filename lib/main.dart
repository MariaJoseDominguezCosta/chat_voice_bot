import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'services/chat_gpt_service.dart';
import 'services/speech_recognition_service.dart';
import 'services/text_to_speech_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ChatGPTService()),
        Provider(create: (_) => SpeechRecognitionService()),
        Provider(create: (_) => TextToSpeechService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Practice ChatBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}