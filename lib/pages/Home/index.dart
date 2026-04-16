import 'package:flutter/material.dart';
import 'package:shop/pages/Home/my_slider.dart';
import 'package:shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewStateState createState() => _HomeViewStateState();
}

class _HomeViewStateState extends State<HomeView> {
  final List<BannerItem> _bannerItems = [
    BannerItem(
        id: "1",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    BannerItem(
        id: "2",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png"),
    BannerItem(
        id: "3",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  ];

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: MySlider(bannerList: _bannerItems)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(),
    );
  }
}
