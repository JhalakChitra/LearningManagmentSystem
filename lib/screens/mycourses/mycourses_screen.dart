import 'package:flutter/material.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            courseCard(
              title: "Flutter Development",
              progress: 0.65,
              lessons: "20 Lessons",
            ),
            courseCard(
              title: "Python Programming",
              progress: 0.40,
              lessons: "15 Lessons",
            ),
            courseCard(
              title: "UI/UX Designing",
              progress: 0.85,
              lessons: "25 Lessons",
            ),
          ],
        ),
      ),
    );
  }

  Widget courseCard({
    required String title,
    required double progress,
    required String lessons,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              ),
            ),
            const SizedBox(height: 6),
            Text(
              lessons,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 10),

            // Progress Bar
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(6),
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 8),

            Text("${(progress * 100).toInt()}% Completed"),
          ],
        ),
      ),
    );
  }
}
