import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    final reg = courseProvider.getStudentRegistration(auth.currentUser?.id ?? '');
    final enrolledCourse = (reg != null && reg.status == 'CONFIRMED')
        ? courseProvider.courses.firstWhere((c) => c.id == reg.courseId)
        : null;

    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    final timeSlots = ['10:00 AM - 11:00 AM', '02:00 PM - 03:30 PM', '03:30 PM - 05:00 PM'];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.royalBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.royalBlue),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.royalBlue, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Timetable Conflict Checker Matrix',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.royalBlue),
                        ),
                        Text(
                          'Ensures your NME elective does not clash with core departmental lectures.',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(color: AppColors.royalBlue.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: AppColors.royalBlue),
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text('Time Slot', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    ...days.map((day) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(day, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        )),
                  ],
                ),
                ...timeSlots.map((slot) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(slot, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                      ),
                      ...days.map((day) {
                        final isScheduled = enrolledCourse != null &&
                            enrolledCourse.scheduleDays.contains(day) &&
                            enrolledCourse.scheduleTime == slot;
                        return Container(
                          height: 60,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: isScheduled ? AppColors.warmGold.withOpacity(0.3) : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: isScheduled ? Border.all(color: AppColors.warmGold, width: 1.5) : null,
                          ),
                          child: isScheduled
                              ? Center(
                                  child: Text(
                                    enrolledCourse.code,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.royalBlue),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        );
                      }),
                    ],
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
            if (enrolledCourse != null)
              Card(
                color: AppColors.seatGreen.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.seatGreen),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.seatGreen, size: 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Zero Timetable Conflicts for ${enrolledCourse.title} (${enrolledCourse.scheduleDays} ${enrolledCourse.scheduleTime})',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
