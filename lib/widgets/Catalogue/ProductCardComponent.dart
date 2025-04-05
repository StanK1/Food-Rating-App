import 'package:flutter/material.dart';

class ProductCardComponent extends StatelessWidget {
  final String imageUrl;
  final String productName;

  const ProductCardComponent({
    Key? key,
    this.imageUrl = 'https://dashboard.codeparrot.ai/api/image/Z-aeeh_Ow-G56629/lindt-ca-2.png',
    this.productName = 'Lindt & Sprüngli',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.45, // Responsive width
          height: constraints.maxHeight * 0.3, // Responsive height
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFF4F4F4),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Handle card tap
              },
              borderRadius: BorderRadius.circular(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 66,
                    height: 112,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontFamily: 'Ethnocentric',
                      fontSize: 11,
                      letterSpacing: 0.25,
                      height: 1.82, // 20px line height / 11px font size
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

