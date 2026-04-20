import 'package:flutter/material.dart';
import 'package:shop/viewmodels/home.dart';

class MyCategory extends StatefulWidget {
  // 分類列表
  final List<CategoryItem> categoryItems;
  MyCategory({Key? key, required this.categoryItems}) : super(key: key);

  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryItems.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Image.network(widget.categoryItems[index].picture),
                Text(widget.categoryItems[index].name),
              ],
            ),
          );
        },
      ),
    );
  }
}
