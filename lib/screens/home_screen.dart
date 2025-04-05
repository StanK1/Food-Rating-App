import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'scan_screen.dart';
import 'scan_history_screen.dart';
import 'daily_challenges_screen.dart';
import '../widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05032A),
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF0A0428), Color(0xFF1B0945), Color(0xFF353352)],
          ),
        ),
        child: Stack(
          children: [
            // Animated cosmic background
            Positioned.fill(
              child: _buildStarryBackground(),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Logo and Title Section with animation
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildAnimatedLogo(),
                        const SizedBox(height: 24),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xFFAB2AC2),
                              Color(0xFFF09EFF),
                              Color(0xFF9D71E8),
                              Color(0xFFF09EFF),
                            ],
                            stops: [0.0, 0.3, 0.6, 1.0],
                          ).createShader(bounds),
                          child: const Text(
                            'Welcome to\nChoconavt',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your cosmic chocolate adventure\nawaits in the stars!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Feature Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildFeatureButton(
                          context,
                          'Start Scanning Mission',
                          Icons.qr_code_scanner,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanScreen()),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureButton(
                          context,
                          'Mission History',
                          Icons.history,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScanHistoryScreen()),
                          ),
                          isPrimary: false,
                        ),
                        const SizedBox(height: 16),
                        _buildFeatureButton(
                          context,
                          'Daily Challenges',
                          Icons.star_border,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DailyChallengesScreen()),
                          ),
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildStarryBackground() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: StarFieldPainter(
            animation: _animationController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final pulseValue =
            math.sin(_animationController.value * math.pi * 2) * 0.5 + 0.5;

        return Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  const Color(0xFFF09EFF).withOpacity(0.3 + (pulseValue * 0.2)),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF09EFF)
                    .withOpacity(0.2 + (pulseValue * 0.1)),
                blurRadius: 20 + (pulseValue * 20),
                spreadRadius: pulseValue * 5,
              ),
            ],
          ),
          child: Image.asset(
            'assets/images/logo/astro.png',
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap, {
    bool isPrimary = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          gradient: isPrimary
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFF09EFF).withOpacity(0.8),
                    const Color(0xFFAB2AC2),
                  ],
                )
              : null,
          color: isPrimary ? null : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isPrimary
                ? Colors.white.withOpacity(0.2)
                : const Color(0xFFF09EFF).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFFF09EFF).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFFF09EFF).withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: isPrimary ? 28 : 24,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isPrimary ? 18 : 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  final double animation;
  final random = List.generate(100, (index) => index * 3.14159 * 0.017 * index);

  StarFieldPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw small twinkling stars
    for (int i = 0; i < random.length; i++) {
      final x = (random[i] * 173.13) % size.width;
      final y = (random[i] * 321.37) % size.height;
      final pulseOffset = math.sin((animation * 6.28) + random[i]) * 0.5 + 0.5;

      // Star size varies based on index and animation
      final starSize = (i % 4 == 0)
          ? 2.0
          : (i % 3 == 0)
              ? 1.5
              : 1.0;
      final finalSize = starSize * (0.7 + (pulseOffset * 0.3));

      // Star color varies
      final color = i % 5 == 0
          ? Color.lerp(
              Colors.white, const Color(0xFFF09EFF), pulseOffset * 0.7)!
          : i % 4 == 0
              ? Color.lerp(
                  Colors.white, const Color(0xFF00B4FF), pulseOffset * 0.5)!
              : Colors.white.withOpacity(0.5 + (pulseOffset * 0.5));

      paint.color = color;

      // Draw the star
      canvas.drawCircle(Offset(x, y), finalSize, paint);
    }
  }

  @override
  bool shouldRepaint(StarFieldPainter oldDelegate) => true;
}
