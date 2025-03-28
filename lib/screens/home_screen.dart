import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'scan_history_screen.dart';
import 'daily_challenges_screen.dart';
import '../widgets/bottom_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF05032A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF05032A), Color(0xFF585670)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo and Title Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo/astro.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFF09EFF),
                          Color(0xFFAB2AC2),
                        ],
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
                      'Your cosmic chocolate adventure\nawaits!',
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
                            builder: (context) => const ScanHistoryScreen()),
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
      ),
      bottomNavigationBar: BottomBar(),
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
          color: isPrimary ? null : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFFF09EFF).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
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
