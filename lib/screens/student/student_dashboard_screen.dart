import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/ai_advisor_chat.dart';
import '../../widgets/registration_slip_modal.dart';
import 'course_catalog_screen.dart';
import 'timetable_screen.dart';
import 'credit_ledger_screen.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CourseCatalogScreen(),
    TimetableScreen(),
    CreditLedgerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    final reg = courseProvider.getStudentRegistration(auth.currentUser?.id ?? '');
    final enrolledCourse = (reg != null && reg.status == 'CONFIRMED')
        ? courseProvider.courses.firstWhere((c) => c.id == reg.courseId)
        : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lang.translate('app_title'),
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome, ${auth.currentUser?.name ?? "Student"}',
              style: const TextStyle(color: AppColors.warmGold, fontSize: 12),
            ),
          ],
        ),
        actions: [
          if (reg != null && enrolledCourse != null)
            IconButton(
              icon: const Icon(Icons.qr_code, color: AppColors.warmGold),
              tooltip: 'Digital Pass',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => RegistrationSlipModal(
                    registration: reg,
                    course: enrolledCourse,
                    student: auth.currentUser!,
                  ),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.translate, color: Colors.white),
            tooltip: 'Toggle Tamil/English',
            onPressed: () => Provider.of<LanguageProvider>(context, listen: false).toggleLanguage(),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => auth.logout(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.warmGold,
        foregroundColor: AppColors.deepNavy,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AIAdvisorChatSheet(),
          );
        },
        icon: const Icon(Icons.smart_toy),
        label: const Text('AI Advisor', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.royalBlue,
        unselectedItemColor: AppColors.textMuted,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book),
            label: lang.translate('courses'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: lang.translate('timetable'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet),
            label: lang.translate('credit_ledger'),
          ),
        ],
      ),
    );
  }
}
