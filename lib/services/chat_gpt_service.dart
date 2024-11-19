import 'package:dio/dio.dart';
import '../models/message_model.dart';

class ChatGPTService {
  final Dio _dio = Dio();
  final String _apiKey = 'YOUR_OPENAI_API_KEY'; // Reemplazar con tu API key

  Future<String> generateResponse(List<MessageModel> messages) async {
    try {
      final response = await _dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': messages.map((m) => {
            'role': m.type == MessageType.user ? 'user' : 'assistant',
            'content': m.text,
          }).toList(),
          'max_tokens': 150,
          'temperature': 0.7,
        },
      );

      return response.data['choices'][0]['message']['content'].trim();
    } catch (e) {
      print('Error generating response: $e');
      return 'Lo siento, hubo un error procesando tu solicitud.';
    }
  }
}