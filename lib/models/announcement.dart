class Announcement {
  final String id;
  final String title;
  final String content;
  final String sender;
  final String timestamp;
  final String category;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.category,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      sender: json['sender'] ?? 'Alagappa NME Cell',
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
      category: json['category'] ?? 'IMPORTANT',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'sender': sender,
      'timestamp': timestamp,
      'category': category,
    };
  }
}
