import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../models/course.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';

class DeptAdminDashboardScreen extends StatefulWidget {
  const DeptAdminDashboardScreen({super.key});

  @override
  State<DeptAdminDashboardScreen> createState() => _DeptAdminDashboardScreenState();
}

class _DeptAdminDashboardScreenState extends State<DeptAdminDashboardScreen> {
  void _showAddCourseDialog() {
    final titleController = TextEditingController();
    final codeController = TextEditingController();
    final seatsController = TextEditingController(text: '60');
    final facultyController = TextEditingController(text: 'Dr. R. Ramanathan');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Add New NME Course', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.royalBlue)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Course Title')),
              TextField(controller: codeController, decoration: const InputDecoration(labelText: 'Course Code (e.g. NME-CSE-103)')),
              TextField(controller: seatsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Total Seats')),
              TextField(controller: facultyController, decoration: const InputDecoration(labelText: 'Assigned Instructor')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.royalBlue, foregroundColor: Colors.white),
            onPressed: () {
              if (titleController.text.isNotEmpty && codeController.text.isNotEmpty) {
                final newCourse = Course(
                  id: 'crs-${DateTime.now().millisecondsSinceEpoch}',
                  code: codeController.text,
                  title: titleController.text,
                  description: 'Newly added department elective course.',
                  departmentId: 'dept-cse',
                  departmentName: 'Department of Computer Science',
                  facultyId: 'usr-faculty-1',
                  facultyName: facultyController.text,
                  credits: 3,
                  semester: 3,
                  totalSeats: int.tryParse(seatsController.text) ?? 60,
                  filledSeats: 0,
                  venue: 'Science Block A',
                  scheduleDays: 'Mon, Wed',
                  scheduleTime: '11:00 AM - 12:30 PM',
                  difficulty: 'Beginner',
                  prerequisites: 'None',
                  rating: 5.0,
                  status: 'APPROVED',
                );

                Provider.of<CourseProvider>(context, listen: false).addCourse(newCourse);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🎉 New NME Course added successfully!')),
                );
              }
            },
            child: const Text('Add Course'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    final deptCourses = courseProvider.courses.where((c) => c.departmentId == 'dept-cse').toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Department Admin Portal', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Dept: Computer Science (${auth.currentUser?.name})', style: const TextStyle(color: AppColors.warmGold, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate, color: Colors.white),
            onPressed: () => Provider.of<LanguageProvider>(context, listen: false).toggleLanguage(),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => auth.logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Department Course Catalog',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.royalBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _showAddCourseDialog,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Course'),
                )
              ],
            ),
            const SizedBox(height: 15),
            ...deptCourses.map((c) {
              final ratio = c.filledSeats / c.totalSeats;
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(c.code, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.royalBlue)),
                          Text('${c.filledSeats} / ${c.totalSeats} Enrolled', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(c.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: ratio,
                        backgroundColor: Colors.black12,
                        color: ratio >= 1.0 ? AppColors.seatRed : AppColors.royalBlue,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 8),
                      Text('Instructor: ${c.facultyName} • Venue: ${c.venue}', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
