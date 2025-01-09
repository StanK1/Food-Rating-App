import 'package:flutter/material.dart';

class SignUp2 extends StatelessWidget {
  const SignUp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFF05032A), Color(0xFF585670)],
              ),
            ),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    child: Container(
                      width: 84,
                      height: 81,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        'assets/images/logo/astro.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
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
                  Positioned(
                    left: 24,
                    top: 271,
                    child: _buildInputField(
                      label: 'E-mail address',
                      width: 326,
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 355,
                    child: _buildInputField(
                      label: 'Password',
                      width: 326,
                      isPassword: true,
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 447,
                    child: _buildPasswordStrengthIndicator(),
                  ),
                  const Positioned(
                    left: 24,
                    top: 468,
                    child: SizedBox(
                      width: 326,
                      child: Text(
                        'Use 8 or more characters with a mix of letters, numbers & symbols.',
                        style: TextStyle(
                          color: Color(0xFFC1C1CD),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 540,
                    child: _buildGradientButton(
                      text: 'Get started, it\'s free!',
                      onPressed: () {},
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    child: _SignInSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required double width,
    bool isPassword = false,
  }) {
    return SizedBox(
      width: width,
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
          Container(
            height: 48,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF83839C)),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: TextField(
              obscureText: isPassword,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return SizedBox(
      width: 326,
      height: 5,
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: ShapeDecoration(
                color: const Color(0xFF83839C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
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
              color: const Color(0xFFF09EFF).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: const Color(0xFFAB2AC2).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: -5,
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
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
        TextButton(
          onPressed: () {},
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
      ],
    );
  }
}
