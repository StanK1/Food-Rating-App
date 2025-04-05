import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import 'scan_screen.dart';
import 'scan_history_screen.dart';
import 'daily_challenges_screen.dart';

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  _HomeMenuScreenState createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedMenuIndex = 0;

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

          // Animated star field
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarFieldPainter(
                    animation: _animationController.value,
                  ),
                );
              },
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Header with cosmic styling
                _buildAppHeader(),

                // Orbital navigation
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Central orbit circle
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (_, child) {
                          return CustomPaint(
                            size: const Size(300, 300),
                            painter: CosmicOrbitPainter(
                              animation: _animationController.value,
                            ),
                          );
                        },
                      ),

                      // Menu options in orbit
                      ..._buildOrbitalMenuItems(),

                      // Center cosmic icon
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final pulseValue = math.sin(
                                      _animationController.value *
                                          math.pi *
                                          2) *
                                  0.15 +
                              1.0;

                          return Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFFF09EFF),
                                  Color(0xFFAB2AC2),
                                ],
                                center: Alignment(0, 0),
                                radius: 0.8,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFF09EFF).withOpacity(0.3),
                                  blurRadius: 20 * pulseValue,
                                  spreadRadius: 5 * pulseValue,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.home_rounded,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                // Home action
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Bottom menu bar
                _buildCosmicBottomNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Cosmic logo with shimmer effect
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
              'CHOCONAVT',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          // User profile with cosmic styling
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF09EFF).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF09EFF), Color(0xFFAB2AC2)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      'Choconavt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOrbitalMenuItems() {
    final menuItems = [
      {
        'title': 'Scan',
        'icon': Icons.qr_code_scanner,
        'color': const Color(0xFF00B4FF),
        'angle': 45.0,
        'distance': 120.0,
        'route': const ScanScreen(),
      },
      {
        'title': 'History',
        'icon': Icons.history,
        'color': const Color(0xFFF09EFF),
        'angle': 135.0,
        'distance': 120.0,
        'route': const ScanHistoryScreen(),
      },
      {
        'title': 'Challenges',
        'icon': Icons.star_border,
        'color': const Color(0xFFFFB800),
        'angle': 225.0,
        'distance': 120.0,
        'route': const DailyChallengesScreen(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person_outline,
        'color': const Color(0xFF85DCA9),
        'angle': 315.0,
        'distance': 120.0,
        'route': null,
      },
    ];

    return menuItems.map((item) {
      final angleInRadians = (item['angle'] as double) * (math.pi / 180);
      final distance = item['distance'] as double;

      return Positioned(
        left: MediaQuery.of(context).size.width / 2 -
            45 +
            (math.cos(angleInRadians) * distance),
        top: MediaQuery.of(context).size.height / 2 -
            45 -
            80 +
            (math.sin(angleInRadians) *
                distance), // -80 to account for SafeArea offset
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final pulseValue =
                math.sin(_animationController.value * math.pi * 2) * 0.1 + 1.0;

            return GestureDetector(
              onTap: () {
                if (item['route'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => item['route'] as Widget),
                  );
                }
              },
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: (item['color'] as Color).withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (item['color'] as Color).withOpacity(0.2),
                      blurRadius: 10 * pulseValue,
                      spreadRadius: 2 * pulseValue,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 32,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  Widget _buildCosmicBottomNav() {
    final navItems = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.explore, 'label': 'Explore'},
      {'icon': Icons.star_border_rounded, 'label': 'Rewards'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final isSelected = index == _selectedMenuIndex;

              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final glowValue = isSelected
                      ? math.sin(_animationController.value * math.pi * 2) *
                              0.5 +
                          0.5
                      : 0.0;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedMenuIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            navItems[index]['icon'] as IconData,
                            color: isSelected
                                ? const Color(0xFFF09EFF)
                                : Colors.white.withOpacity(0.6),
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            navItems[index]['label'] as String,
                            style: TextStyle(
                              color: isSelected
                                  ? const Color(0xFFF09EFF)
                                  : Colors.white.withOpacity(0.6),
                              fontSize: 10,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 20,
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFF09EFF),
                                    Color(0xFFAB2AC2)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(1),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF09EFF)
                                        .withOpacity(0.3 + (glowValue * 0.3)),
                                    blurRadius: 4,
                                    spreadRadius: glowValue,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  final double animation;
  final random = List.generate(80, (index) => index * 3.14159 * 0.017 * index);

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

class CosmicOrbitPainter extends CustomPainter {
  final double animation;

  CosmicOrbitPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw main orbital path with glow effect
    final orbitPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    canvas.drawCircle(center, radius, orbitPaint);

    // Draw dashed secondary orbit with animation
    final dashPaint = Paint()
      ..color = const Color(0xFFF09EFF).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const dashLength = 5.0;
    const dashGap = 5.0;
    final circumference = 2 * math.pi * radius;
    final dashCount = (circumference / (dashLength + dashGap)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startAngle =
          (i * (dashLength + dashGap) / circumference) * 2 * math.pi +
              (animation * math.pi * 2);
      final sweepAngle = dashLength / circumference * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.85),
        startAngle,
        sweepAngle,
        false,
        dashPaint,
      );
    }

    // Draw small floating particles along the orbit
    final particlePaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi + (animation * math.pi * 2);
      final x = center.dx + math.cos(angle) * (radius * 0.85);
      final y = center.dy + math.sin(angle) * (radius * 0.85);

      final pulseValue =
          math.sin((animation * 2 * math.pi) + (i * 0.7)) * 0.5 + 0.5;

      // Alternate particle colors
      if (i % 2 == 0) {
        particlePaint.color =
            const Color(0xFFF09EFF).withOpacity(0.5 + (pulseValue * 0.5));
      } else {
        particlePaint.color =
            const Color(0xFF00B4FF).withOpacity(0.5 + (pulseValue * 0.5));
      }

      canvas.drawCircle(
        Offset(x, y),
        1.5 + (pulseValue * 1),
        particlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CosmicOrbitPainter oldDelegate) => true;
}
