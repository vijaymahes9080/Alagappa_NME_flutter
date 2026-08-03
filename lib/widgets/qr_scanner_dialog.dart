import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class QRScannerDialog extends StatefulWidget {
  const QRScannerDialog({super.key});

  @override
  State<QRScannerDialog> createState() => _QRScannerDialogState();
}

class _QRScannerDialogState extends State<QRScannerDialog> {
  final TextEditingController _codeController = TextEditingController(text: 'NME-2026-88101');
  bool _isScanned = false;
  String _scanResult = '';

  void _verifyRegistrationCode(String code) {
    setState(() {
      _isScanned = true;
      if (code.contains('NME-2026') || code.contains('88101')) {
        _scanResult = '✅ VERIFIED PASS\n\nStudent: K. Vijaykumar (2024101001)\nCourse: NME-CSE-101 Python Programming\nStatus: Active Seat Reserved';
      } else {
        _scanResult = '❌ INVALID OR EXPIRED PASS';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.qr_code_scanner, color: AppColors.royalBlue, size: 28),
                const SizedBox(width: 10),
                const Text(
                  'Classroom Attendance Scanner',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.royalBlue, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 48, color: AppColors.royalBlue),
                  const SizedBox(height: 8),
                  const Text('Camera QR Scanner Active', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Align student pass inside frame', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Pass Code Manually',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: AppColors.royalBlue),
                  onPressed: () => _verifyRegistrationCode(_codeController.text),
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (_isScanned)
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _scanResult.contains('VERIFIED') ? AppColors.seatGreen.withValues(alpha: 0.15) : AppColors.seatRed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _scanResult.contains('VERIFIED') ? AppColors.seatGreen : AppColors.seatRed,
                  ),
                ),
                child: Text(
                  _scanResult,
                  style: TextStyle(
                    color: _scanResult.contains('VERIFIED') ? Colors.green[900] : Colors.red[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.royalBlue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => _verifyRegistrationCode(_codeController.text),
              child: const Text('Simulate Scan Verification'),
            )
          ],
        ),
      ),
    );
  }
}
