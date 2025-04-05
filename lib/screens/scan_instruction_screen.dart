import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'scan_screen.dart';

class ScanInstructionScreen extends StatefulWidget {
  const ScanInstructionScreen({super.key});

  @override
  State<ScanInstructionScreen> createState() => _ScanInstructionScreenState();
}

class _ScanInstructionScreenState extends State<ScanInstructionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Simplify to a single animation controller
  // Remove multiple separate animations for different elements

  // Simple hover state for button
  bool _isButtonHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      // Slower animation for a more subtle effect
      duration: const Duration(seconds: 15),
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
      body: Stack(
        children: [
          // Cosmic background gradient
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  Color(0xFF05032A),
                  Color(0xFF1B0945),
                  Color(0xFF353352)
                ],
              ),
            ),
          ),

          // Simplified star field - single layer instead of parallax
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: SimpleStarFieldPainter(
                    animation: _animationController.value,
                  ),
                );
              },
            ),
          ),

          // Main content without scroll
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Simplified logo animation - just a subtle glow
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final pulseValue =
                        math.sin(_animationController.value * math.pi) * 0.3 +
                            0.7;
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/logo/astro.png'),
                          fit: BoxFit.contain,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF09EFF)
                                .withOpacity(0.2 + (pulseValue * 0.1)),
                            blurRadius: 15,
                            spreadRadius: 2 * pulseValue,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Simplified title with static gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFF09EFF),
                      Colors.white,
                      Color(0xFFF09EFF),
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ).createShader(bounds),
                  child: const Text(
                    'Welcome to the\nChocolate Galaxy!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Regular text instead of character animation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Ready for your cosmic chocolate adventure?\nLet\'s explore the universe of flavors!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),

                // Instructions Container with simplified styling
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            const Color(0xFF353352).withOpacity(0.5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFFF09EFF).withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF09EFF).withOpacity(0.1),
                            blurRadius: 15,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    _buildInstructionItem(
                                      icon: Icons.qr_code_scanner,
                                      title: 'Mission: Scan',
                                      description:
                                          'Point your scanner at the chocolate bar\'s cosmic code',
                                      iconColor: const Color(0xFF00B4FF),
                                    ),
                                    _buildCosmicDivider(),
                                    _buildInstructionItem(
                                      icon: Icons.rate_review,
                                      title: 'Share Your Discovery',
                                      description:
                                          'Tell other Choconavts about your chocolate adventure',
                                      iconColor: const Color(0xFFF09EFF),
                                    ),
                                    _buildCosmicDivider(),
                                    _buildInstructionItem(
                                      icon: Icons.stars_rounded,
                                      title: 'Collect Stardust',
                                      description:
                                          'Earn 150 ChocoPoints on your first mission!\nThen 50 points for each new discovery',
                                      isSpecial: true,
                                      iconColor: const Color(0xFFFFB800),
                                    ),
                                  ],
                                ),
                              ),

                              // Simple badge with gentle pulse
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    final pulseValue = math.sin(
                                                _animationController.value *
                                                    math.pi) *
                                            0.02 +
                                        0.98;

                                    return Transform.scale(
                                      scale: pulseValue,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFFFB800),
                                              Color(0xFFFF8A00),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFFFFB800)
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.rocket_launch,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'BONUS: First scan gets 2x points!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Simplified button with subtle animation
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, bottom: 24, top: 12),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isButtonHovered = true),
                    onExit: (_) => setState(() => _isButtonHovered = false),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      scale: _isButtonHovered ? 1.03 : 1.0,
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanScreen()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFFF09EFF).withOpacity(0.8),
                                const Color(0xFFAB2AC2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF09EFF).withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                                spreadRadius: 1,
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Begin Scanning Mission',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              const Color(0xFFF09EFF).withOpacity(0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionItem({
    required IconData icon,
    required String title,
    required String description,
    bool isSpecial = false,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Simplified icon container
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: iconColor.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: isSpecial
                ? [
                    BoxShadow(
                      color: iconColor.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        // Text content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSpecial ? const Color(0xFFFFB800) : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Simplified star field with fewer stars and subtle animation
class SimpleStarFieldPainter extends CustomPainter {
  final double animation;
  final random = List.generate(60, (index) => index * 3.14159 * 0.017 * index);

  SimpleStarFieldPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw stars with simpler animation
    for (int i = 0; i < random.length; i++) {
      final x = (random[i] * 173.13) % size.width;
      final y = (random[i] * 321.37) % size.height;

      // More subtle pulsing
      final pulseOffset = math.sin((animation * 3.14) + random[i]) * 0.3 + 0.7;

      // Simplified star size
      final starSize = (i % 4 == 0)
          ? 2.0
          : (i % 3 == 0)
              ? 1.5
              : 1.0;
      final finalSize = starSize * pulseOffset;

      // Simplified color variation
      final color = i % 5 == 0
          ? Color.lerp(Colors.white, const Color(0xFFF09EFF), 0.6)!
          : i % 4 == 0
              ? Color.lerp(Colors.white, const Color(0xFF00B4FF), 0.4)!
              : Colors.white.withOpacity(0.8);

      paint.color = color;

      // Draw the star
      canvas.drawCircle(Offset(x, y), finalSize, paint);
    }

    // Add just a few special stars with glow
    _drawSpecialStars(canvas, size);
  }

  void _drawSpecialStars(Canvas canvas, Size size) {
    for (int i = 0; i < 3; i++) {
      final seed = random[(i * 7) % random.length];
      final x = (seed * 173.13) % size.width;
      final y = (seed * 321.37) % size.height;

      final pulseOffset = math.sin((animation * 2.0) + seed) * 0.3 + 0.7;

      // Simple glow effect
      final glowPaint = Paint()
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final starColors = [
        const Color(0xFFF09EFF),
        const Color(0xFF00B4FF),
        const Color(0xFFFFB800),
      ];

      final starColor = starColors[i % starColors.length];
      glowPaint.color = starColor.withOpacity(0.2 * pulseOffset);

      canvas.drawCircle(Offset(x, y), 6 * pulseOffset, glowPaint);

      // Inner star
      final starPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Color.lerp(starColor, Colors.white, 0.5)!;

      canvas.drawCircle(Offset(x, y), 2, starPaint);
    }
  }

  @override
  bool shouldRepaint(SimpleStarFieldPainter oldDelegate) => true;
}
