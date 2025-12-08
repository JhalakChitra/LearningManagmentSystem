import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            statisticsCard(
              title: "Completed Courses",
              value: "12",
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            statisticsCard(
              title: "Pending Courses",
              value: "5",
              icon: Icons.pending_actions,
              color: Colors.orange,
            ),
            statisticsCard(
              title: "Certificates Earned",
              value: "7",
              icon: Icons.workspace_premium,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            const Divider(),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  reportTile("Flutter Development", "Completed"),
                  reportTile("Python Programming", "In Progress"),
                  reportTile("UI/UX Designing", "Completed"),
                  reportTile("Java Programming", "In Progress"),
                  reportTile("Machine Learning", "Completed"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget statisticsCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget reportTile(String course, String status) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(course, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(
        status,
        style: TextStyle(
          color: status == "Completed" ? Colors.green : Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
