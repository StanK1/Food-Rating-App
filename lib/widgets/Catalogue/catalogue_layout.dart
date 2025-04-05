import 'package:flutter/material.dart';
import 'HeaderComponent.dart';
import 'SearchBarComponent.dart';
import 'CategoryTabsComponent.dart';
import 'ViewToggleComponent.dart';
import 'ProductCardComponent.dart';

class CatalogueLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(5, 3, 42, 1),
              Color.fromRGBO(88, 86, 112, 1),
            ],
          ),
        ),
        child: Column(
          children: [
            HeaderComponent(),
            SizedBox(height: 10),
            SearchBarComponent(),
            SizedBox(height: 10),
            CategoryTabsComponent(),
            SizedBox(height: 10),
            ViewToggleComponent(),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 157.84 / 197.56,
                ),
                itemCount: 8, // Assuming there are 8 products
                itemBuilder: (context, index) {
                  return ProductCardComponent(
                    imageUrl: index % 2 == 0 ? 'https://dashboard.codeparrot.ai/api/image/Z-aeeh_Ow-G56629/lindt-ca-2.png' : 'https://dashboard.codeparrot.ai/api/image/Z-aeeh_Ow-G56629/milka-1-2.png',
                    productName: 'Lindt & Sprüngli',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

