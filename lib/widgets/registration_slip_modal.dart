import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/app_colors.dart';
import '../models/registration.dart';
import '../models/course.dart';
import '../models/user.dart';

class RegistrationSlipModal extends StatelessWidget {
  final Registration registration;
  final Course course;
  final User student;

  const RegistrationSlipModal({
    super.key,
    required this.registration,
    required this.course,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.royalBlue, AppColors.deepNavy],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.account_balance, color: AppColors.warmGold, size: 28),
                SizedBox(width: 8),
                Text(
                  'ALAGAPPA UNIVERSITY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const Text(
              'NME Official Registration Slip',
              style: TextStyle(color: AppColors.warmGold, fontSize: 12),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  QrImageView(
                    data: registration.registrationNo,
                    version: QrVersions.auto,
                    size: 150.0,
                    foregroundColor: AppColors.deepNavy,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    registration.registrationNo,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.royalBlue,
                    ),
                  ),
                  const Divider(height: 20),
                  _buildDetailRow('Student:', student.name),
                  _buildDetailRow('Reg No:', student.registerNumber ?? '2024101001'),
                  _buildDetailRow('Course:', course.title),
                  _buildDetailRow('Code:', course.code),
                  _buildDetailRow('Venue:', course.venue),
                  _buildDetailRow('Schedule:', '${course.scheduleDays} ${course.scheduleTime}'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.seatGreen.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'STATUS: VERIFIED & CONFIRMED',
                      style: TextStyle(color: AppColors.seatGreen, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.warmGold),
                  ),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 18),
                  label: const Text('Close'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warmGold,
                    foregroundColor: AppColors.deepNavy,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('📱 Registration Pass saved to downloads!')),
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download Pass'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textMuted)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
