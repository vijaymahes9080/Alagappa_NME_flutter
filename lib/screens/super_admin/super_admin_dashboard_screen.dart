import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() => _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  void _showBroadcastDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Broadcast University Announcement', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.royalBlue)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Announcement Title')),
            const SizedBox(height: 10),
            TextField(controller: contentController, maxLines: 3, decoration: const InputDecoration(labelText: 'Message Body')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.royalBlue, foregroundColor: Colors.white),
            onPressed: () {
              if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                Provider.of<CourseProvider>(context, listen: false).addAnnouncement(
                  titleController.text,
                  contentController.text,
                  'Super Admin NME Cell',
                );
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('📣 University-wide Announcement broadcasted!')),
                );
              }
            },
            child: const Text('Broadcast Now'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.royalBlue,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Super Admin Portal', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('University NME Nodal Cell (${auth.currentUser?.name})', style: const TextStyle(color: AppColors.warmGold, fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.campaign, color: AppColors.warmGold),
            tooltip: 'Broadcast Announcement',
            onPressed: _showBroadcastDialog,
          ),
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
            // Analytics Header Matrix
            Row(
              children: [
                _buildStatCard('Total Seats', '${courseProvider.totalSeats}', Icons.event_seat, AppColors.royalBlue),
                const SizedBox(width: 10),
                _buildStatCard('Enrolled', '${courseProvider.totalFilledSeats}', Icons.how_to_reg, AppColors.seatGreen),
                const SizedBox(width: 10),
                _buildStatCard('Fill Rate', '${courseProvider.overallFillPercentage.toStringAsFixed(1)}%', Icons.pie_chart, AppColors.warmGold),
              ],
            ),
            const SizedBox(height: 20),
            // System Health Monitor Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: AppColors.deepNavy,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.monitor_heart, color: AppColors.seatGreen, size: 24),
                        SizedBox(width: 8),
                        Text('System Health & Socket Sync Monitor', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 20),
                    _buildHealthRow('REST API Gateway', 'ONLINE (http://localhost:5000/api/v1)', AppColors.seatGreen),
                    _buildHealthRow('Socket.io Seat Sync', 'CONNECTED (12 ms latency)', AppColors.seatGreen),
                    _buildHealthRow('Database Cluster', 'HEALTHY (0.8% load)', AppColors.seatGreen),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('University Broadcast Announcements', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_alert, color: AppColors.royalBlue),
                  onPressed: _showBroadcastDialog,
                )
              ],
            ),
            const SizedBox(height: 8),
            ...courseProvider.announcements.map((ann) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: const Icon(Icons.campaign, color: AppColors.crimsonMaroon, size: 30),
                  title: Text(ann.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('${ann.content}\n— ${ann.sender} (${ann.timestamp})', style: const TextStyle(fontSize: 12)),
                  isThreeLine: true,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String val, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(val, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 2),
            Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthRow(String label, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}
