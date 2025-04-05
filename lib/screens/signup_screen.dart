import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'login_screen.dart';
import 'firstmessege_screen.dart';
import 'Register_screen.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _agreedToTerms = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  int _passwordStrength = 0;
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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient with animated stars
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

          // Animated star field background
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

          // Main content with scroll
          SingleChildScrollView(
            child: Container(
              width: screenSize.width,
              constraints: BoxConstraints(
                minHeight: screenSize.height,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
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
                          },
                        ),

                        // App name with shimmering effect
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

                        const SizedBox(height: 10),
                        // Form fields with improved cosmic styling
                        _buildInputField(
                          label: 'Username',
                          controller: _usernameController,
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Username is required';
                            }
                            if (value!.length < 3) return 'Username too short';
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'E-mail address',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty ?? true)
                              return 'Email is required';
                            if (!value!.contains('@')) return 'Invalid email';
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Password',
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Password is required';
                            }
                            if (value!.length < 8) return 'Password too short';
                            return null;
                          },
                          onChanged: _checkPasswordStrength,
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordStrengthIndicator(),

                        const SizedBox(height: 16),
                        _buildInputField(
                          label: 'Confirm Password',
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outline,
                          isPassword: true,
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),
                        _buildTermsCheckbox(),

                        const SizedBox(height: 24),
                        // Cosmic animated button
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            final glowIntensity = (math.sin(
                                        _animationController.value * math.pi) +
                                    1) /
                                2;
                            return _buildGradientButton(
                              text: 'Get started, it\'s free!',
                              onPressed: _submitForm,
                              glowIntensity: glowIntensity,
                            );
                          },
                        ),

                        const SizedBox(height: 12),
                        const _SignInSection(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    double? width,
    bool isPassword = false,
    TextEditingController? controller,
    IconData? icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFC1C1CD),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: icon != null
                  ? Icon(icon, color: const Color(0xFF83839C))
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF83839C)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF83839C)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFFF09EFF), width: 2),
              ),
              filled: true,
              fillColor: Colors.black.withOpacity(0.2),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final List<Color> strengthColors = [
      const Color(0xFF83839C), // Empty
      const Color(0xFFFF4D4D), // Weak
      const Color(0xFFFFB800), // Medium
      const Color(0xFF00C48C), // Strong
      const Color(0xFF00C48C), // Very Strong
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index < _passwordStrength
                      ? strengthColors[_passwordStrength]
                      : strengthColors[0],
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: index < _passwordStrength
                      ? [
                          BoxShadow(
                            color: strengthColors[_passwordStrength]
                                .withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getPasswordStrengthText(),
          style: TextStyle(
            color: strengthColors[_passwordStrength],
            fontSize: 12,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  String _getPasswordStrengthText() {
    switch (_passwordStrength) {
      case 0:
        return 'Enter password';
      case 1:
        return 'Weak password';
      case 2:
        return 'Fair password';
      case 3:
        return 'Strong password';
      case 4:
        return 'Very strong password';
      default:
        return '';
    }
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
    double glowIntensity = 0.0,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 324,
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
              color: const Color(0xFFF09EFF)
                  .withOpacity(0.3 + (glowIntensity * 0.2)),
              blurRadius: 12 + (glowIntensity * 8),
              offset: const Offset(0, 4),
              spreadRadius: glowIntensity * 2,
            ),
            BoxShadow(
              color: const Color(0xFFAB2AC2).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: -5,
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.1 + (glowIntensity * 0.1)),
            width: 1,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
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
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color:
                _agreedToTerms ? const Color(0xFFF09EFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _agreedToTerms
                  ? const Color(0xFFF09EFF)
                  : const Color(0xFF83839C),
              width: 1.5,
            ),
            boxShadow: _agreedToTerms
                ? [
                    BoxShadow(
                      color: const Color(0xFFF09EFF).withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  _agreedToTerms = !_agreedToTerms;
                });
              },
              child: _agreedToTerms
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreedToTerms = !_agreedToTerms;
              });
            },
            child: Text(
              'I agree to the Terms of Service and Privacy Policy',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Proceed with signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FirstMessege()),
      );
    }
  }

  void _checkPasswordStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    setState(() {
      _passwordStrength = strength;
    });
  }
}

class _SignInSection extends StatelessWidget {
  const _SignInSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Do you have already an account?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color(0xFFF09EFF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF09EFF).withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
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
