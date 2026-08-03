import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/course_card.dart';
import '../../widgets/voice_search_bar.dart';

class CourseCatalogScreen extends StatelessWidget {
  const CourseCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    final departments = [
      {'id': 'ALL', 'name': 'All Depts'},
      {'id': 'dept-cse', 'name': 'Computer Science'},
      {'id': 'dept-mgt', 'name': 'Management'},
      {'id': 'dept-com', 'name': 'Commerce'},
      {'id': 'dept-tam', 'name': 'Tamil Literature'},
    ];

    return Scaffold(
      body: Column(
        children: [
          const VoiceSearchBar(),
          // Department Horizontal Filter Pills
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final dept = departments[index];
                final isSelected = courseProvider.selectedDepartmentId == dept['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(dept['name']!),
                    selected: isSelected,
                    selectedColor: AppColors.royalBlue,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.royalBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    onSelected: (_) {
                      courseProvider.setSelectedDepartment(dept['id']!);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: courseProvider.filteredCourses.isEmpty
                ? const Center(
                    child: Text('No courses found matching criteria.', style: TextStyle(color: AppColors.textMuted)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: courseProvider.filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = courseProvider.filteredCourses[index];
                      return CourseCard(course: course);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
