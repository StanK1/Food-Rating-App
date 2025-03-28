import 'package:flutter/material.dart';
import '../screens/scan_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/login_screen.dart';
import 'dart:ui';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
          // color: Colors.transparent,
          // borderRadius: BorderRadius.circular(16),
          ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background shape for the bar
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withAlpha(20),
                      Colors.white.withAlpha(5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withAlpha(30),
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFF09EFF).withAlpha(5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Center scan button
          Positioned(
            top: -25,
            left: MediaQuery.of(context).size.width / 2 - 33,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              child: Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color(0xFFF09EFF), // Light pink
                      Color(0xFFAB2AC2), // Dark purple
                    ],
                    center: Alignment(0, 0),
                    radius: 0.8,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x7FAB2AC2), // Purple shadow
                      blurRadius: 25,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),

          // Navigation Items
          Positioned.fill(
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.home, size: 26),
                  onPressed: () {},
                  color: Color(0xFFF09EFF), // Active color
                ),
                IconButton(
                  icon: Icon(Icons.rocket_launch, size: 24),
                  onPressed: () {},
                  color: Colors.white.withAlpha(150), // Inactive color
                ),
                SizedBox(width: 80),
                IconButton(
                  icon: Icon(Icons.book, size: 24),
                  onPressed: () {},
                  color: Colors.white.withAlpha(150),
                ),
                IconButton(
                  icon: Icon(Icons.person, size: 24),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  color: Colors.white.withAlpha(150),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
