import 'package:flutter/material.dart';

class CategoryTabsComponent extends StatefulWidget {
  final List<String> categories;
  final int initialIndex;

  const CategoryTabsComponent({
    super.key,
    this.categories = const ['Milk', 'Vegan', 'Dark', 'Special'],
    this.initialIndex = 0,
  });

  @override
  _CategoryTabsComponentState createState() => _CategoryTabsComponentState();
}

class _CategoryTabsComponentState extends State<CategoryTabsComponent> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double tabWidth =
            (constraints.maxWidth - 20) / widget.categories.length;
        return Container(
          height: 32,
          decoration: BoxDecoration(
            color: Color(0x6B585670),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFF585670),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.categories.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  width: tabWidth,
                  height: 32,
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Color(0xFF7714AE)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.categories[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.33, // 32px line height / 24px font size
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
