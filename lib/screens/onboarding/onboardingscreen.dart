import 'package:flutter/material.dart';
import '../auth/login.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "Learn Anytime",
      "subtitle": "Access courses anytime, anywhere",
    },
    {
      "title": "Track Progress",
      "subtitle": "Check your reports & results easily",
    },
    {
      "title": "Interactive Courses",
      "subtitle": "Best quality learning content",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              onboardingData[index]["title"]!,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              onboardingData[index]["subtitle"]!,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),

      bottomSheet: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dots
            Row(
              children: List.generate(
                onboardingData.length,
                    (index) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  height: 10,
                  width: pageIndex == index ? 25 : 10,
                  decoration: BoxDecoration(
                    color: pageIndex == index ? Colors.deepPurple : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            // Next Or Get Started
            ElevatedButton(
              onPressed: () {
                if (pageIndex == onboardingData.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }
              },
              child: Text(
                  pageIndex == onboardingData.length - 1 ? "Get Started" : "Next"),
            ),
          ],
        ),
      ),
    );
  }
}
