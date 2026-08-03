import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../models/course.dart';
import '../providers/auth_provider.dart';
import '../providers/course_provider.dart';
import '../providers/language_provider.dart';
import 'seat_badge.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTapDetails;

  const CourseCard({
    super.key,
    required this.course,
    this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);
    
    final studentId = auth.currentUser?.id ?? '';
    final isRegistered = courseProvider.isStudentRegistered(studentId, course.id);
    final isWaitlisted = courseProvider.isStudentWaitlisted(studentId, course.id);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isRegistered ? AppColors.seatGreen : AppColors.royalBlue.withOpacity(0.15),
          width: isRegistered ? 2 : 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.royalBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.code,
                    style: const TextStyle(
                      color: AppColors.royalBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SeatBadge(course: course),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              course.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              course.departmentName,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              course.description,
              maxLines: 2,
              overflow: TextSpanOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, height: 1.3),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: AppColors.warmGold),
                const SizedBox(width: 4),
                Text(course.facultyName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                const Spacer(),
                const Icon(Icons.schedule, size: 16, color: AppColors.warmGold),
                const SizedBox(width: 4),
                Text('${course.scheduleDays} (${course.scheduleTime})', style: const TextStyle(fontSize: 11)),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.crimsonMaroon.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${course.credits} Credits',
                    style: const TextStyle(color: AppColors.crimsonMaroon, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: AppColors.warmGold),
                    const SizedBox(width: 2),
                    Text('${course.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                if (auth.currentUser?.role == UserRole.STUDENT) ...[
                  if (isRegistered)
                    Chip(
                      avatar: const Icon(Icons.check_circle, color: Colors.white, size: 16),
                      label: Text(lang.translate('registered')),
                      backgroundColor: AppColors.seatGreen,
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    )
                  else if (isWaitlisted)
                    Chip(
                      avatar: const Icon(Icons.access_time_filled, color: Colors.white, size: 16),
                      label: Text(lang.translate('waitlisted')),
                      backgroundColor: AppColors.seatAmber,
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    )
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: course.isFull ? AppColors.seatAmber : AppColors.royalBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      ),
                      onPressed: () {
                        final result = courseProvider.registerCourse(studentId, course);
                        if (result == 'SUCCESS') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('🎉 Registration Successful! Digital Pass generated.'),
                              backgroundColor: AppColors.seatGreen,
                            ),
                          );
                        } else if (result == 'WAITLISTED') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('⏳ Course Full! Added to Auto-Waitlist position #1.'),
                              backgroundColor: AppColors.seatAmber,
                            ),
                          );
                        } else if (result == 'TIMETABLE_CONFLICT') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('⚠️ Timetable Conflict! You are already registered for a course at this time.'),
                              backgroundColor: AppColors.seatRed,
                            ),
                          );
                        }
                      },
                      child: Text(
                        course.isFull ? lang.translate('waitlist') : lang.translate('register'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
