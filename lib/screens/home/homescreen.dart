import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),   // 👈 ADDED
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // SEARCH BAR
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search courses...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    // BANNER
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDE96DE),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "50% OFF",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "275+ Courses",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text("Get Started"),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // TITLE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Popular Courses 🔥",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 10),

                    // COURSE CARDS
                    buildCourseCard("Figma UI Design", "\$35",
                        "assets/course1.png"),
                    buildCourseCard(
                        "3D Illustration", "\$48", "assets/course2.png"),
                    buildCourseCard(
                        "3D Illustration", "\$48", "assets/course2.png"),
                    buildCourseCard(
                        "3D Illustration", "\$48", "assets/course2.png"),
                    buildCourseCard(
                        "3D Illustration", "\$48", "assets/course2.png"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library), label: "My Courses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Report"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // COURSE CARD
  Widget buildCourseCard(String title, String price, String img) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(price,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
