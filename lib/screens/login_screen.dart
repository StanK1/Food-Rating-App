import 'package:flutter/material.dart';
import 'Register_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF05032A), Color(0xFF585670)],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Logo
                Positioned(
                  left: (screenSize.width - 84) / 2, // Center horizontally
                  top: screenSize.height * 0.1, // Adjust top spacing
                  child: Container(
                    width: 84,
                    height: 81,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo/astro.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // App name
                Positioned(
                  left: (screenSize.width - 243) / 2, // Center horizontally
                  top: screenSize.height * 0.2, // Adjust spacing after logo
                  child: Container(
                    width: 243,
                    height: 49,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/logo/choconavttext.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Login input
                Positioned(
                  left: 24,
                  top: screenSize.height * 0.35, // Adjust vertical position
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
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFF83839C)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFF83839C)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFFF09EFF)),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Password input
                Positioned(
                  left: 24,
                  top: screenSize.height * 0.45, // Adjust vertical position
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
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFF83839C)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFF83839C)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: Color(0xFFF09EFF)),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
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
                  top: screenSize.height * 0.55, // Adjust vertical position
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
                            child: Container(
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
                      const Text(
                        'Forgot password',
                        style: TextStyle(
                          color: Color(0xFF83839C),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Sign In button
                Positioned(
                  left: 26,
                  right: 26,
                  top: screenSize.height * 0.63, // Adjust vertical position
                  child: GestureDetector(
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
                  ),
                ),

                // Sign Up section
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: screenSize.height * 0.05, // Adjust bottom spacing
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
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 26),
                          height: 48,
                          decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Colors.white.withOpacity(0.15),
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
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
    );
  }
}
