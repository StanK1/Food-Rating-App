import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'Register_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  bool _rememberMe = false;
  late AnimationController _animationController;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Cosmic background with stars
          Container(
            width: screenSize.width,
            height: screenSize.height,
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

          // Star field animation
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
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
          SingleChildScrollView(
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              child: SafeArea(
                child: Stack(
                  children: [
                    // Logo with glowing effect
                    Positioned(
                      left: (screenSize.width - 84) / 2,
                      top: screenSize.height * 0.1,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final glowValue = math.sin(
                                      _animationController.value *
                                          math.pi *
                                          2) *
                                  0.5 +
                              0.5;
                          return Container(
                            width: 84,
                            height: 81,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/logo/astro.png'),
                                fit: BoxFit.contain,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF09EFF)
                                      .withOpacity(0.2 + (glowValue * 0.3)),
                                  blurRadius: 20 + (glowValue * 15),
                                  spreadRadius: 5 * glowValue,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // App name with shimmer effect
                    Positioned(
                      left: (screenSize.width - 243) / 2,
                      top: screenSize.height * 0.2,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFF09EFF),
                            Colors.white,
                            Color(0xFFF09EFF),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ).createShader(bounds),
                        child: Container(
                          width: 243,
                          height: 49,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/logo/choconavttext.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Login input
                    Positioned(
                      left: 24,
                      top: screenSize.height * 0.35,
                      child: SizedBox(
                        width: screenSize.width - 48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFFA2A2B5),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.3)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF83839C)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF83839C)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF09EFF), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Password input
                    Positioned(
                      left: 24,
                      top: screenSize.height * 0.45,
                      child: SizedBox(
                        width: screenSize.width - 48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Password',
                              style: TextStyle(
                                color: Color(0xFFA2A2B5),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.3)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF83839C)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF83839C)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF09EFF), width: 2),
                                ),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Remember me and Forgot password
                    Positioned(
                      left: 24,
                      right: 24,
                      top: screenSize.height * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 24,
                                  height: 24,
                                  decoration: ShapeDecoration(
                                    color: _rememberMe
                                        ? const Color(0xFFF09EFF)
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Color(0xFF83839C)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    shadows: _rememberMe
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFFF09EFF)
                                                  .withOpacity(0.5),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: _rememberMe
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rememberMe = !_rememberMe;
                                  });
                                },
                                child: const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Color(0xFF83839C),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Forgot password logic
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot password',
                              style: TextStyle(
                                color: Color(0xFFF09EFF),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sign In button with animation
                    Positioned(
                      left: 26,
                      right: 26,
                      top: screenSize.height * 0.63,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final glowIntensity =
                              (math.sin(_animationController.value * math.pi) +
                                      1) /
                                  2;
                          return GestureDetector(
                            onTap: () {
                              // Add your sign in logic here
                            },
                            child: Container(
                              width: screenSize.width - 52,
                              height: 48,
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
                                    color: const Color(0xFFF09EFF).withOpacity(
                                        0.3 + (glowIntensity * 0.2)),
                                    blurRadius: 12 + (glowIntensity * 8),
                                    offset: const Offset(0, 4),
                                    spreadRadius: glowIntensity * 2,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFFAB2AC2).withOpacity(
                                        0.2 + (glowIntensity * 0.1)),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                    spreadRadius: -5,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white
                                      .withOpacity(0.1 + (glowIntensity * 0.1)),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Sign Up section
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: screenSize.height * 0.05,
                      child: Column(
                        children: [
                          const Text(
                            "If you don't have an account yet?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()),
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              height: 48,
                              decoration: ShapeDecoration(
                                color: Colors.black.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.5,
                                    color: const Color(0xFFF09EFF)
                                        .withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: const Color(0xFFF09EFF)
                                        .withOpacity(0.1),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
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
              ),
            ),
          ),
        ],
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
