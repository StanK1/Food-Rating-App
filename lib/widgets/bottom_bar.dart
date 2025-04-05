import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/scan_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/scan_history_screen.dart';
import 'dart:ui';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();

    // Enable edge-to-edge mode to allow content to draw behind system navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Make system navigation bar transparent
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Main background container with blur
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: 62,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Navigation items
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      filledIcon: Icons.home_rounded,
                      label: 'Home',
                      index: 0,
                      onTap: () {
                        setState(() => _selectedIndex = 0);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.rocket_launch_outlined,
                      filledIcon: Icons.rocket_launch_rounded,
                      label: 'Explore',
                      index: 1,
                      onTap: () => setState(() => _selectedIndex = 1),
                    ),
                    // Center space for scan button
                    SizedBox(width: 60),
                    _buildNavItem(
                      icon: Icons.history_outlined,
                      filledIcon: Icons.history_rounded,
                      label: 'History',
                      index: 3,
                      onTap: () {
                        setState(() => _selectedIndex = 3);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScanHistoryScreen()),
                        );
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.person_outline_rounded,
                      filledIcon: Icons.person_rounded,
                      label: 'Profile',
                      index: 4,
                      onTap: () {
                        setState(() => _selectedIndex = 4);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Center scan button
            Positioned(
              top: 0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final scale = 0.95 + (0.05 * _animationController.value);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFCE5DEB),
                            Color(0xFFAB2AC2),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFAB2AC2).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() => _selectedIndex = 2);
                            _animationController.reset();
                            _animationController.forward();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScanScreen()),
                            );
                          },
                          customBorder: const CircleBorder(),
                          highlightColor: Colors.white.withOpacity(0.2),
                          splashColor: Colors.white.withOpacity(0.2),
                          child: const Center(
                            child: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData filledIcon,
    required String label,
    required int index,
    required VoidCallback onTap,
  }) {
    final bool isSelected = index == _selectedIndex;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        highlightColor: Colors.white.withOpacity(0.05),
        splashColor: Colors.white.withOpacity(0.05),
        child: Container(
          width: 65,
          padding: const EdgeInsets.only(top: 6, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isSelected ? filledIcon : icon,
                  size: isSelected ? 24 : 22,
                  color: isSelected
                      ? const Color(0xFFF09EFF)
                      : Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.3,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFFF09EFF)
                      : Colors.white.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
