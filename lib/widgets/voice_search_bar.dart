import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../providers/course_provider.dart';
import '../providers/language_provider.dart';

class VoiceSearchBar extends StatefulWidget {
  const VoiceSearchBar({super.key});

  @override
  State<VoiceSearchBar> createState() => _VoiceSearchBarState();
}

class _VoiceSearchBarState extends State<VoiceSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;

  void _simulateVoiceSearch() {
    setState(() {
      _isListening = true;
    });

    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final simulatedQueries = lang.isTamil
        ? ['பைதான்', 'தமிழ்', 'வணிகவியல்', 'சைபர் செக்யூரிட்டி']
        : ['Python', 'Tamil Literature', 'Finance', 'Cyber Security'];

    final query = (simulatedQueries..shuffle()).first;

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isListening = false;
          _controller.text = query;
        });
        Provider.of<CourseProvider>(context, listen: false).setSearchQuery(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: AppColors.royalBlue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.royalBlue),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: lang.translate('search_courses'),
                hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
                border: InputBorder.none,
              ),
              onChanged: (val) => courseProvider.setSearchQuery(val),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {
                _controller.clear();
                courseProvider.setSearchQuery('');
              },
            ),
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: _isListening ? AppColors.seatRed : AppColors.warmGold,
            ),
            onPressed: _simulateVoiceSearch,
            tooltip: 'Voice Search Controller',
          ),
        ],
      ),
    );
  }
}
