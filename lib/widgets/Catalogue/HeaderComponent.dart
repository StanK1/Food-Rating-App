import 'package:flutter/material.dart';

class HeaderComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const HeaderComponent({
    Key? key,
    this.title = 'CHOCOLATES',
    this.onBackPressed,
    this.onMenuPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Fixed height to accommodate content with padding
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(5, 3, 42, 1), // Inherit top-level background color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          InkWell(
            onTap: onBackPressed ?? () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              'https://dashboard.codeparrot.ai/api/image/Z-aeeh_Ow-G56629/arrow-ba.png',
              width: 24,
              height: 24,
            ),
          ),
          // Title
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Ethnocentric',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.0, // lineHeight 20px / fontSize 20
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Menu button
          InkWell(
            onTap: onMenuPressed ?? () {},
            child: Container(
              width: 24,
              height: 17.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 2, color: Colors.white),
                  Container(height: 2, color: Colors.white),
                  Container(height: 2, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

