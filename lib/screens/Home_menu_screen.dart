import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  _HomeMenuScreenState createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _rocketController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _rocketController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _circleController.dispose();
    _rocketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF46248E),
              Color(0xFF2E1A5C),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'CHOCONAVT',
                      style: TextStyle(
                        fontFamily: 'Ethnocentric',
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning 🔥',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  NavigationBar(),
                ],
              ),
              Positioned(
                left: 83,
                top: 223,
                child: SizedBox(
                  width: 472,
                  height: 472,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _circleController,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: _circleController.value * 2 * math.pi,
                            child: child,
                          );
                        },
                        child: CustomPaint(
                          size: const Size(472, 472),
                          painter: DashedCirclePainter(),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _rocketController,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: _rocketController.value * 2 * math.pi,
                            child: Transform.translate(
                              offset: const Offset(0, -220),
                              child: const Icon(
                                Icons.rocket_launch,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const AnimatedCircle(index: 0, color: Color(0xFF192126), size: 100, top: 0, left: 186),
                      const AnimatedCircle(index: 1, color: Color(0xFF192126), size: 75, top: 50, right: 0),
                      const AnimatedCircle(index: 2, color: Color(0xFF192126), size: 115, bottom: 50, left: 0),
                      const AnimatedCircle(index: 3, color: Color(0xFF192126), size: 75, bottom: 0, right: 75),
                      const AnimatedCircle(index: 4, color: Color(0xFF192126), size: 75, bottom: 50, right: 0, icon: Icons.search),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.white30
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    const dashSize = 5;
    const dashSpace = 5;
    double startAngle = 0;

    while (startAngle < 360) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * (math.pi / 180),
        dashSize * (math.pi / 180),
        false,
        paint,
      );
      startAngle += dashSize + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AnimatedCircle extends StatefulWidget {
  final int index;
  final Color color;
  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final IconData? icon;

  const AnimatedCircle({
    super.key,
    required this.index,
    required this.color,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.icon,
  });

  @override
  _AnimatedCircleState createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    Future.delayed(Duration(milliseconds: widget.index * 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleActive() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      bottom: widget.bottom,
      left: widget.left,
      right: widget.right,
      child: ScaleTransition(
        scale: _animation,
        child: GestureDetector(
          onTap: _toggleActive,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isActive ? const Color(0xFFB9EAFD) : widget.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: _isActive ? const Color(0xFF192126) : const Color(0xFFB9EAFD),
                    size: widget.size * 0.4,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavButton(icon: Icons.home, label: 'Home', isActive: true),
          NavButton(icon: Icons.rocket_launch, label: 'Explore'),
          NavButton(icon: Icons.bar_chart, label: 'Stats'),
          NavButton(icon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const NavButton({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFB9EAFD) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? const Color(0xFF192126) : Colors.white),
          if (isActive) const SizedBox(width: 4),
          if (isActive)
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF192126),
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
