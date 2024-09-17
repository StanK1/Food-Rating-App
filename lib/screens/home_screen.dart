import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'scan_history_screen.dart';
import 'daily_challenges_screen.dart';
import 'home_menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chocolate Rating App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              child: const Text('Scan a Chocolate'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanHistoryScreen()),
                );
              },
              child: const Text('View Scanned Chocolates'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DailyChallengesScreen()),
                );
              },
              child: const Text('Daily Challenges'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const HomeMenuScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = 0.0;
                const end = 1.0;
                var tween = Tween(begin: begin, end: end);
                var curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                );

                return ScaleTransition(
                  scale: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.search),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
