import 'package:flutter/material.dart';
import 'dart:math' as math;

class DailyChallengesScreen extends StatefulWidget {
  const DailyChallengesScreen({super.key});

  @override
  State<DailyChallengesScreen> createState() => _DailyChallengesScreenState();
}

class _DailyChallengesScreenState extends State<DailyChallengesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedTaskIndex = -1;

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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCosmicAppBar(context),
                    const SizedBox(height: 20),
                    _buildHeroSection(),
                    const SizedBox(height: 20),
                    _buildChallengeInfo(),
                    const SizedBox(height: 24),
                    _buildTasksList(),
                    const SizedBox(height: 24),
                    _buildStartChallenge(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCosmicAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Row(
        children: [
          // Back button with cosmic styling
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF09EFF).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          // Title with shimmer effect
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
              'Daily Challenges',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          // Info button
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                // Show info
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF09EFF).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Hero image
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/daily_challenges_astronaut.png',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.35),
            ),
          ),

          // Cosmic overlay
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF05032A).withOpacity(0.9),
                  ],
                  stops: const [0.5, 1.0],
                ).createShader(bounds),
                blendMode: BlendMode.darken,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),

          // Animated cosmic decoration
          Positioned(
            right: 20,
            top: 20,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: CosmicShapePainter(_animationController.value),
                  size: const Size(40, 40),
                );
              },
            ),
          ),

          // Challenge info panel
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF09EFF).withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      Icons.access_time,
                      'Time Left',
                      '6 hours',
                      const Color(0xFF00B4FF),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.local_fire_department,
                      'Completed',
                      '1/4 tasks',
                      const Color(0xFFF09EFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      IconData icon, String title, String value, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final pulseValue =
                  math.sin(_animationController.value * math.pi * 2) * 0.5 +
                      0.5;

              return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: iconColor.withOpacity(0.3 + (pulseValue * 0.2)),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.1 + (pulseValue * 0.1)),
                      blurRadius: 8 + (pulseValue * 4),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cosmic Chocolate Challenge',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Complete all daily challenges to advance to the next level! Earn cosmic points to get exclusive promotions and unlock rare chocolates in your journey.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        // Progress indicator
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.3),
            const Color(0xFF353352).withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF09EFF).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Level Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFB800), Color(0xFFFF8A00)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Level 3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              // Base progress bar
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Progress
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final pulseValue =
                      math.sin(_animationController.value * math.pi * 2) *
                              0.02 +
                          1.0;

                  return Container(
                    height: 8,
                    width:
                        MediaQuery.of(context).size.width * 0.25 * pulseValue,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFF09EFF),
                          Color(0xFFAB2AC2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF09EFF).withOpacity(0.5),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '250 / 1000 XP',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              Text(
                'Next Reward: 750 XP',
                style: TextStyle(
                  color: const Color(0xFFF09EFF),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    final tasks = [
      {
        'title': 'Welcome Challenge',
        'description': 'Login for 3 consecutive days',
        'reward': 50,
        'icon': Icons.login,
        'completed': true,
      },
      {
        'title': 'Scan Mission',
        'description': 'Scan 3 different chocolate bars',
        'reward': 100,
        'icon': Icons.qr_code_scanner,
        'completed': false,
      },
      {
        'title': 'Cosmic Review',
        'description': 'Write your first chocolate review',
        'reward': 150,
        'icon': Icons.rate_review,
        'completed': false,
      },
      {
        'title': 'Share Journey',
        'description': 'Share your chocolate discovery with friends',
        'reward': 200,
        'icon': Icons.share,
        'completed': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today\'s Missions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFF09EFF).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                '${tasks.where((task) => task['completed'] as bool).length}/${tasks.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Tasks list
        ...List.generate(
          tasks.length,
          (index) => _buildTaskItem(
            index,
            tasks[index]['title'] as String,
            tasks[index]['description'] as String,
            tasks[index]['reward'] as int,
            tasks[index]['icon'] as IconData,
            tasks[index]['completed'] as bool,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(int index, String title, String description, int reward,
      IconData icon, bool completed) {
    final isSelected = index == _selectedTaskIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTaskIndex = isSelected ? -1 : index;
        });
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final glowIntensity = completed || isSelected
              ? math.sin(_animationController.value * math.pi) * 0.1 + 0.1
              : 0.0;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: completed
                    ? [
                        const Color(0xFF1B0945).withOpacity(0.8),
                        const Color(0xFF353352).withOpacity(0.8),
                      ]
                    : [
                        Colors.black.withOpacity(0.3),
                        const Color(0xFF353352).withOpacity(0.5),
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: completed
                    ? const Color(0xFFF09EFF).withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: completed
                      ? const Color(0xFFF09EFF).withOpacity(glowIntensity)
                      : Colors.transparent,
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: completed
                                ? const Color(0xFFF09EFF).withOpacity(0.7)
                                : Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: completed
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFF09EFF)
                                        .withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          icon,
                          color: completed
                              ? const Color(0xFFF09EFF)
                              : Colors.white.withOpacity(0.7),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: completed
                                    ? const Color(0xFFF09EFF)
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              description,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: completed
                              ? const Color(0xFF1B0945)
                              : Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: completed
                                ? const Color(0xFFF09EFF).withOpacity(0.5)
                                : Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              completed ? Icons.check_circle : Icons.star,
                              color: completed
                                  ? const Color(0xFFF09EFF)
                                  : const Color(0xFFFFB800),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              completed ? 'Done!' : '+$reward XP',
                              style: TextStyle(
                                color: completed
                                    ? const Color(0xFFF09EFF)
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded task details
                if (isSelected)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mission Details',
                          style: TextStyle(
                            color: const Color(0xFFF09EFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          completed
                              ? 'Congratulations! You\'ve completed this mission and earned $reward XP!'
                              : 'Complete this mission to earn $reward XP and progress towards your next level. Unlock special rewards and discover new chocolate flavors!',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!completed)
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to complete the mission
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF09EFF),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                child: const Text('Start Mission'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStartChallenge() {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final glowIntensity =
              (math.sin(_animationController.value * math.pi) + 1) / 2;

          return InkWell(
            onTap: () {
              // Start challenge functionality
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                    color: const Color(0xFFF09EFF)
                        .withOpacity(0.3 + (glowIntensity * 0.2)),
                    blurRadius: 12 + (glowIntensity * 8),
                    offset: const Offset(0, 4),
                    spreadRadius: glowIntensity * 2,
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.1 + (glowIntensity * 0.1)),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Start Daily Challenge',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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

class CosmicShapePainter extends CustomPainter {
  final double animation;

  CosmicShapePainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw cosmic shape
    final path = Path();
    final numberOfPoints = 5;
    final radius = size.width * 0.4;
    final innerRadius = radius * 0.4;

    for (int i = 0; i < numberOfPoints * 2; i++) {
      final angle = (i * math.pi / numberOfPoints) + (animation * math.pi);
      final currentRadius = i.isEven ? radius : innerRadius;

      final x = centerX + math.cos(angle) * currentRadius;
      final y = centerY + math.sin(angle) * currentRadius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    final paint = Paint()
      ..color = const Color(0xFFF09EFF).withOpacity(0.7)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Add glow effect
    final glowPaint = Paint()
      ..color = const Color(0xFFF09EFF).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(path, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
