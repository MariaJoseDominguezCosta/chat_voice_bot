enum MessageType { user, bot }

class MessageModel {
  final String text;
  final MessageType type;
  final DateTime timestamp;

  MessageModel({
    required this.text,
    required this.type,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      type: MessageType.values.firstWhere((e) => e.toString() == json['type']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}