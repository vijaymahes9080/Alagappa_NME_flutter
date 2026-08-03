import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../widgets/certificate_modal.dart';

class CreditLedgerScreen extends StatelessWidget {
  const CreditLedgerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    final reg = courseProvider.getStudentRegistration(auth.currentUser?.id ?? '');
    final enrolledCourse = (reg != null && reg.status == 'CONFIRMED')
        ? courseProvider.courses.firstWhere((c) => c.id == reg.courseId)
        : null;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: AppColors.royalBlue,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(auth.currentUser?.avatar ?? ''),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.currentUser?.name ?? '',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              'Reg No: ${auth.currentUser?.registerNumber ?? "2024101001"}',
                              style: const TextStyle(color: AppColors.warmGold, fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(height: 25, color: Colors.white24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('CGPA', '${auth.currentUser?.cgpa ?? 8.85}'),
                        _buildStat('NME Credits', '${enrolledCourse?.credits ?? 0} / 3'),
                        _buildStat('Honors Status', 'QUALIFIED'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.seatGreen.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.seatGreen),
              ),
              child: Row(
                children: const [
                  Icon(Icons.workspace_premium, color: AppColors.seatGreen, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Govt. of Tamil Nadu Tuition Fee Waiver Active',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.seatGreen),
                        ),
                        Text(
                          '100% NME course registration fee exempted for UG full-time students.',
                          style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Earned NME Certificates & Badges',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (enrolledCourse != null)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: const Icon(Icons.stars, color: AppColors.warmGold, size: 36),
                  title: Text(enrolledCourse.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('${enrolledCourse.code} • ${enrolledCourse.credits} Credits Passed'),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.royalBlue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CertificateModal(
                          student: auth.currentUser!,
                          courseTitle: enrolledCourse.title,
                        ),
                      );
                    },
                    child: const Text('View Badge'),
                  ),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: Text('Register for an NME course to view certificate & credits.')),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.warmGold, fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}
