import 'package:flutter/material.dart';
import 'package:shop/contants/index.dart';

class MySuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;
  MySuggestion({Key? key, required this.specialRecommendResult})
      : super(key: key);

  @override
  _MySuggestionState createState() => _MySuggestionState();
}

class _MySuggestionState extends State<MySuggestion> {
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _getChildrenList(),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (index) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(list[index].picture,
                width: 100, height: 140, fit: BoxFit.cover),
          ),
          Container(child: Text(list[index].price))
        ],
      );
    });
  }
}
