import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../services/ai_advisor_service.dart';

class AIAdvisorChatSheet extends StatefulWidget {
  const AIAdvisorChatSheet({super.key});

  @override
  State<AIAdvisorChatSheet> createState() => _AIAdvisorChatSheetState();
}

class _AIAdvisorChatSheetState extends State<AIAdvisorChatSheet> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'bot',
      'text': '👋 Hello! I am your Alagappa AI Course Advisor. Ask me anything about NME courses, Python, Tamil Literature, Finance, or schedule recommendations!'
    }
  ];

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _msgController.clear();
    });

    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final reply = AIAdvisorService.getRecommendationResponse(
      text,
      courseProvider.courses,
      auth.currentUser?.cgpa,
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _messages.add({'sender': 'bot', 'text': reply});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.royalBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.warmGold,
                  child: Icon(Icons.smart_toy, color: AppColors.deepNavy),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI NME Course Advisor',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Alagappa Recommendation Bot',
                      style: TextStyle(color: AppColors.warmGold, fontSize: 11),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isBot = msg['sender'] == 'bot';
                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isBot ? AppColors.cardDark : AppColors.royalBlue,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomLeft: isBot ? Radius.zero : const Radius.circular(16),
                        bottomRight: !isBot ? Radius.zero : const Radius.circular(16),
                      ),
                      border: Border.all(
                        color: isBot ? AppColors.warmGold.withOpacity(0.3) : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      msg['text'] ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.3),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.deepNavy,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ask AI Advisor (e.g. recommend Python or Finance)...',
                      hintStyle: const TextStyle(color: Colors.white54, fontSize: 12),
                      fillColor: AppColors.cardDark,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: AppColors.warmGold),
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: AppColors.deepNavy),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
