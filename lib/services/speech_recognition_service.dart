import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechRecognitionService {
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;

  Future<void> initialize() async {
    await _speechToText.initialize();
  }

  Future<String?> startListening({
    Duration listenFor = const Duration(seconds: 30),
    Duration pauseFor = const Duration(seconds: 3),
  }) async {
    if (!_speechToText.isAvailable) return null;

    _isListening = true;
    String? recognizedText;

    await _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          recognizedText = result.recognizedWords;
        }
      },
      listenFor: listenFor,
      pauseFor: pauseFor,
      cancelOnError: true,
    );

    return recognizedText;
  }

  void stopListening() {
    _speechToText.stop();
    _isListening = false;
  }

  bool get isListening => _isListening;
}