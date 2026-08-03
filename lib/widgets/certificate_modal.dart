import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user.dart';

class CertificateModal extends StatelessWidget {
  final User student;
  final String courseTitle;

  const CertificateModal({
    super.key,
    required this.student,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.warmGold, width: 4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.workspace_premium, color: AppColors.warmGold, size: 54),
            const SizedBox(height: 10),
            const Text(
              'ALAGAPPA UNIVERSITY',
              style: TextStyle(
                color: AppColors.royalBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.2,
              ),
            ),
            const Text(
              'KARAIKUDI, TAMIL NADU',
              style: TextStyle(color: AppColors.crimsonMaroon, fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 25, thickness: 1.5, color: AppColors.warmGold),
            const Text(
              'CERTIFICATE OF COMPLETION',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.deepNavy,
              ),
            ),
            const SizedBox(height: 12),
            const Text('This is to certify that', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.royalBlue,
              ),
            ),
            Text(
              'Reg. No: ${student.registerNumber ?? "2024101001"}',
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
            const SizedBox(height: 10),
            const Text('has successfully completed the Non-Major Elective (NME) course', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Text(
              courseTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.crimsonMaroon,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  children: [
                    Text('Dr. R. Ramanathan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                    Text('Course Instructor', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                  ],
                ),
                Icon(Icons.verified, color: AppColors.warmGold, size: 36),
                Column(
                  children: [
                    Text('NME Nodal Officer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                    Text('Alagappa University', style: TextStyle(fontSize: 9, color: AppColors.textMuted)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.royalBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('📜 Official Certificate PDF downloaded!')),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.picture_as_pdf, size: 18),
              label: const Text('Download Official PDF'),
            )
          ],
        ),
      ),
    );
  }
}
