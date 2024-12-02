import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatefulWidget {
  const CategoryListTile({super.key, required this.categoryName, required this.categoryTotalAmount});
  final String categoryName;
  final String categoryTotalAmount;

  @override
  State<CategoryListTile> createState() => _CategoryListTileState();
}

class _CategoryListTileState extends State<CategoryListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("${widget.categoryName}", style: const TextStyle(fontSize: 12,  fontFamily: "Product Sans"),),
          ),
          Text("Ksh. ${widget.categoryTotalAmount}", style: const TextStyle(fontSize: 12,  fontFamily: "Product Sans"),),
        ],
      ),
    );
  }
}
