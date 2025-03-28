import 'package:flutter/material.dart';
import 'survey_screen.dart';

class FirstMessege extends StatelessWidget {
  const FirstMessege({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
              // Logo at top
              Positioned(
                left: (screenSize.width - 280) / 2,
                top: 58,
                child: Container(
                  width: 280,
                  height: 46,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo/choconavttext.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Welcome Text
              Positioned(
                left: 24,
                top: 169,
                child: SizedBox(
                  width: screenSize.width - 48,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Hi, ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text: 'CHOCONAVT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            letterSpacing: 1,
                          ),
                        ),
                        TextSpan(
                          text: '! \n\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                          ),
                        ),
                        TextSpan(
                          text:
                              'This is your Captain speaking. You are requested to explore the never-ending universe of chocolate! Before we begin your quest, you need to participate in a mini-task which will help with your conscription. ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                            letterSpacing: 0.20,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Select Preferences Button
              Positioned(
                left: 25,
                right: 25,
                top: 416,
                child: GestureDetector(
                  onTap: () {
                    // Add navigation to preferences screen
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFFF09EFF).withOpacity(0.8),
                          const Color(0xFFAB2AC2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(999),
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
                    child: const Center(
                      child: Text(
                        'Select your preferences',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Skip Button
              Positioned(
                left: 25,
                right: 25,
                top: 492,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyScreen()),
                    );
                  },
                  child: Container(
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
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.43,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Add a primary action button
              Positioned(
                left: 25,
                right: 25,
                top: 420,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SurveyScreen()),
                    );
                  },
                  child: Container(
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
                        ),
                        BoxShadow(
                          color: const Color(0xFFAB2AC2).withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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
