import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/qr_scanner_dialog.dart';

class FacultyDashboardScreen extends StatefulWidget {
  const FacultyDashboardScreen({super.key});

  @override
  State<FacultyDashboardScreen> createState() => _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState extends State<FacultyDashboardScreen> {
  double _assignmentWeight = 40.0;
  double _quizWeight = 20.0;
  double _examWeight = 40.0;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);
    final lang = Provider.of<LanguageProvider>(context);

    final facultyCourse = courseProvider.courses.firstWhere(
      (c) => c.facultyId == auth.currentUser?.id,
      orElse: () => courseProvider.courses.first,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Faculty Portal', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Instructor: ${auth.currentUser?.name}', style: const TextStyle(color: AppColors.warmGold, fontSize: 12)),
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
            // Quick QR Scanner Banner
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: AppColors.deepNavy,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const Icon(Icons.qr_code_scanner, color: AppColors.warmGold, size: 48),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Classroom Attendance Scanner',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Verify student NME digital registration pass slips instantly.',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.warmGold,
                        foregroundColor: AppColors.deepNavy,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const QRScannerDialog(),
                        );
                      },
                      child: const Text('Scan QR'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Assigned Course: ${facultyCourse.title}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildMetricCard('Total Enrolled', '${facultyCourse.filledSeats} Students', AppColors.royalBlue),
                const SizedBox(width: 12),
                _buildMetricCard('Seat Capacity', '${facultyCourse.totalSeats} Max', AppColors.seatGreen),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Grading Rubric Builder',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildSliderRow('Assignments & Projects:', _assignmentWeight, (val) => setState(() => _assignmentWeight = val)),
                    _buildSliderRow('Quizzes & Participation:', _quizWeight, (val) => setState(() => _quizWeight = val)),
                    _buildSliderRow('End Semester Exam:', _examWeight, (val) => setState(() => _examWeight = val)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Weight: ${(_assignmentWeight + _quizWeight + _examWeight).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.royalBlue),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.royalBlue, foregroundColor: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Grading Rubric criteria published successfully!')),
                            );
                          },
                          child: const Text('Save Rubric'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Enrolled Student Roster',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.royalBlue,
                  child: Text('KV', style: TextStyle(color: Colors.white)),
                ),
                title: const Text('K. Vijaykumar (Reg: 2024101001)', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Dept of Management • CGPA 8.85'),
                trailing: const Chip(
                  label: Text('CONFIRMED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  backgroundColor: AppColors.seatGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String val, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(val, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderRow(String label, double val, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text('${val.toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.warmGold)),
          ],
        ),
        Slider(
          value: val,
          min: 0,
          max: 100,
          divisions: 20,
          activeColor: AppColors.royalBlue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
