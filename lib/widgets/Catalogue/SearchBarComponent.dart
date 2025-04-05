import 'package:flutter/material.dart';

class SearchBarComponent extends StatelessWidget {
  final Function(String)? onSearch;
  final String? placeholder;

  const SearchBarComponent({
    Key? key,
    this.onSearch,
    this.placeholder = 'Search...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minWidth: 335,
        maxHeight: 32,
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(
              'https://dashboard.codeparrot.ai/api/image/Z-aeeh_Ow-G56629/search-1.png',
              width: 24,
              height: 24,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFE1E1E1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFFE1E1E1),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

