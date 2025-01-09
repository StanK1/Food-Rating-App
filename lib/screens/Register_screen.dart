import 'package:flutter/material.dart';
import 'signup_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(children: [
        SignUp1(),
      ]),
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
        body: SingleChildScrollView(
          child: Column(children: [
            SignUp1(),
          ]),
        ),
      ),
    );
  }
}

class SignUp1 extends StatelessWidget {
  const SignUp1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF05032A), Color(0xFF353352), Color(0xFF585670)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo placeholder
                Container(
                  width: 84,
                  height: 81,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/logo/astro.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // App name image
                Container(
                  width: 243,
                  height: 49,
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Image.asset(
                    'assets/images/logo/choconavttext.png',
                    fit: BoxFit.contain,
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

                // Or divider
                const Text(
                  'or',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                // Sign up with Email button
                _buildSignUpButton(
                  icon: Icons.email,
                  text: 'Sign up with E-mail',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp2()),
                    );
                  },
                  backgroundColor: Colors.white.withOpacity(0.1),
                ),

                const SizedBox(height: 24),

                // Terms text
                const Text(
                  'By registering, you agree to our Terms of Use. Learn how we collect, use and share your data.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF666680),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
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
              color: Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          backgroundColor: backgroundColor ?? Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: textColor),
            const SizedBox(width: 8),
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
