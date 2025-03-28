import 'package:flutter/material.dart';
import 'scan_screen.dart';

class ScanInstructionScreen extends StatelessWidget {
  const ScanInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background Pattern
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ).createShader(bounds);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo/astro.png'),
                    fit: BoxFit.cover,
                    opacity: 0.05,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [
                  const Color(0xFF05032A),
                  const Color(0xFF585670).withOpacity(0.9),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      // Logo with Glow Effect
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/logo/astro.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Welcome Text with Gradient
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.9),
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          'Welcome to the\nChocolate Galaxy!',
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
                      const SizedBox(height: 24),
                      // Subtitle with Animation
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Ready for your cosmic chocolate adventure?\nLet\'s explore the universe of flavors!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            fontFamily: 'Inter',
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Instructions Container with Glass Effect
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildInstructionItem(
                              icon: Icons.qr_code_scanner,
                              title: 'Mission: Scan',
                              description:
                                  'Point your scanner at the chocolate bar\'s cosmic code',
                              delay: 200,
                              iconSize: 28,
                              titleSize: 18,
                              descriptionSize: 15,
                            ),
                            const SizedBox(height: 24),
                            _buildInstructionItem(
                              icon: Icons.rate_review,
                              title: 'Share Your Discovery',
                              description:
                                  'Tell other Choconavts about your chocolate adventure',
                              delay: 400,
                              iconSize: 28,
                              titleSize: 18,
                              descriptionSize: 15,
                            ),
                            const SizedBox(height: 24),
                            _buildInstructionItem(
                              icon: Icons.stars_rounded,
                              title: 'Collect Stardust',
                              description:
                                  'Earn 150 ChocoPoints on your first mission!\nThen 50 points for each new discovery',
                              isSpecial: true,
                              delay: 600,
                              iconSize: 28,
                              titleSize: 18,
                              descriptionSize: 15,
                            ),
                          ],
                        ),
                      ),
                      // Bonus Badge
                      TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: 0.6 + (0.4 * value),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 24),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFB800),
                                const Color(0xFFFF8A00),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFB800).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'First Mission Bonus: +100 Stardust!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            _buildActionButton(
                              context,
                              'Start Scanning',
                              Icons.qr_code_scanner,
                              isPrimary: true,
                            ),
                            const SizedBox(height: 16),
                            _buildActionButton(
                              context,
                              'Skip',
                              Icons.arrow_forward,
                              isPrimary: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
    bool isSpecial = false,
    int delay = 0,
    double iconSize = 28,
    double titleSize = 18,
    double descriptionSize = 15,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: isSpecial
                  ? LinearGradient(
                      colors: [
                        const Color(0xFFFFB800).withOpacity(0.2),
                        const Color(0xFFFF8A00).withOpacity(0.2),
                      ],
                    )
                  : null,
              color: isSpecial ? null : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSpecial
                    ? const Color(0xFFFFB800).withOpacity(0.3)
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            child: Icon(
              icon,
              color: isSpecial ? const Color(0xFFFFB800) : Colors.white,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSpecial ? const Color(0xFFFFB800) : Colors.white,
                    fontSize: titleSize,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: descriptionSize,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon, {
    bool isPrimary = true,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ScanScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        height: isPrimary ? 56 : 48,
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
          borderRadius: BorderRadius.circular(16),
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
              size: isPrimary ? 24 : 20,
            ),
            SizedBox(width: isPrimary ? 12 : 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isPrimary ? 16 : 15,
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
