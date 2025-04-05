import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'signup_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignUp1(),
    );
  }
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: SignUp1(),
      ),
    );
  }
}

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> with SingleTickerProviderStateMixin {
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
    return Stack(
      children: [
        // Background gradient with animated stars
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF05032A), Color(0xFF1B0945), Color(0xFF353352)],
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
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with cosmic glow
                    AnimatedBuilder(
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
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF09EFF)
                                      .withOpacity(0.2 + (glowValue * 0.3)),
                                  blurRadius: 20 + (glowValue * 15),
                                  spreadRadius: 5 * glowValue,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logo/astro.png',
                              fit: BoxFit.contain,
                            ),
                          );
                        }),

                    // App name with shimmer effect
                    ShaderMask(
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
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Image.asset(
                          'assets/images/logo/choconavttext.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // Sign up with Apple button
                    _buildSignUpButton(
                      icon: Icons.apple,
                      text: 'Sign up with Apple',
                      onPressed: () {},
                      backgroundColor: Colors.black,
                    ),

                    const SizedBox(height: 16),

                    // Sign up with Google button
                    _buildSignUpButton(
                      icon: Icons.g_mobiledata,
                      text: 'Sign up with Google',
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      iconSize: 24,
                    ),

                    const SizedBox(height: 16),

                    // Sign up with Facebook button
                    _buildSignUpButton(
                      icon: Icons.facebook,
                      text: 'Sign up with Facebook',
                      onPressed: () {},
                      backgroundColor: const Color(0xFF1771E6),
                    ),

                    const SizedBox(height: 20),

                    // Or divider with cosmic styling
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.white.withOpacity(0.3),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.1),
                                ],
                                begin: Alignment.center,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Sign up with Email button with animation
                    AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          final pulseValue =
                              math.sin(_animationController.value * math.pi) *
                                      0.5 +
                                  0.5;
                          return _buildSignUpButton(
                            icon: Icons.email,
                            text: 'Sign up with E-mail',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp2()),
                              );
                            },
                            backgroundColor: Colors.transparent,
                            borderColor: const Color(0xFFF09EFF)
                                .withOpacity(0.3 + (pulseValue * 0.2)),
                            shadowColor: const Color(0xFFF09EFF)
                                .withOpacity(0.1 + (pulseValue * 0.1)),
                            borderWidth: 1.5,
                          );
                        }),

                    const SizedBox(height: 24),

                    // Terms text
                    Text(
                      'By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? borderColor,
    Color? shadowColor,
    double? borderWidth,
    Color textColor = Colors.white,
    double iconSize = 16,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: BorderSide(
              color: borderColor ?? Colors.white.withOpacity(0.15),
              width: borderWidth ?? 1,
            ),
          ),
          backgroundColor: backgroundColor ?? Colors.transparent,
          shadowColor: shadowColor,
          elevation: shadowColor != null ? 4 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: textColor),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
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
