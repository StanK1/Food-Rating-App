import 'package:flutter/material.dart';

class DailyChallengesScreen extends StatelessWidget {
  const DailyChallengesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF192126),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavigation(),
                const SizedBox(height: 28),
                _buildHeaderImage(),
                const SizedBox(height: 18),
                //_buildTimeInfo(),
                const SizedBox(height: 24),
                _buildChallengeInfo(),
                const SizedBox(height: 28),
                _buildTaskList(),
                const SizedBox(height: 16),
                _buildStartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          const Icon(Icons.arrow_back, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            'Daily Challenge',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        image: const DecorationImage(
          image: AssetImage('assets/images/daily_challenges_astronaut.png'),
          fit: BoxFit.cover,
          alignment: Alignment(0, -0.35),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 134,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(23)),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 46,
            right: 46,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoItem(Icons.access_time, 'Time Left', '6 hours'),
                  Container(
                    width: 1,
                    height: 38,
                    color: Colors.white.withOpacity(0.25),
                  ),
                  _buildInfoItem(Icons.check_circle_outline, 'Done', '15 tasks'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFB9EAFD),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(icon, color: const Color(0xFF191D1A), size: 36),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Poppins'),
            ),
            Text(
              value,
              style: TextStyle(color: Color(0xFF44CBFF), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChallengeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Challenges',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Complete all daily challenges to advance to the next level! Earn more points to get exclusive promotions for all the chocolate sweeties!',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 15,
            fontFamily: 'Lato',
          ),
        ),
      ],
    );
  }

  //Widget _buildTimeInfo() {
    //return Text(
      //'Next challenge in: 2h 30m',
    //  style: TextStyle(
    //    color: Colors.white,
    //    fontSize: 16,
    //    fontWeight: FontWeight.w500,
    //    fontFamily: 'Poppins',
    //  ),
    //);
  //}

  Widget _buildTaskList() {
    final tasks = [
      'Welcome back! Let\'s begin...',
      'Write a choco-review',
      'Scan 3 Chocolates',
      'Complete All Daily Challenges',
    ];
    final points = [100, 300, 250, 500];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tasks',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: 'Lato'),
            ),
            Text(
              '1/4',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Lato'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(
          tasks.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildTaskItem(tasks[index], points[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String task, int points) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF384046),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            margin: const EdgeInsets.only(left: 8),
            //decoration: BoxDecoration(
            //  color: const Color(0xFF192126),
            //  borderRadius: BorderRadius.circular(13),
            //),
            child: Image.asset(
              'assets/images/daily_screen_rocket_luncher.png',
              fit: BoxFit.contain
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task,
                  style: TextStyle(color: const Color(0xFFC8C1BB), fontSize: 13.5, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                ),
                const SizedBox(height: 4),
                Text(
                  '$points points',
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13, fontFamily: 'Lato'),
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF192126),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Color(0xFF37B6E9), size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFB9EAFD),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: Text(
          'Let\'s Begin',
          style: TextStyle(
            color: const Color(0xFF192126),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
