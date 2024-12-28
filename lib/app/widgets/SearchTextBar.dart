import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTextBar extends StatelessWidget {
  const SearchTextBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200]
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search Product...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none
        ),
      ),
    );
  }
}
