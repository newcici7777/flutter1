import 'package:flutter/material.dart';
import 'package:shop/api/home.dart';
import 'package:shop/pages/Home/my_category.dart';
import 'package:shop/pages/Home/my_slider.dart';
import 'package:shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewStateState createState() => _HomeViewStateState();
}

class _HomeViewStateState extends State<HomeView> {
  // 分類列表
  List<CategoryItem> _categoryItems = [];
  // 輪播圖列表
  List<BannerItem> _bannerItems = [];
  // List<BannerItem> _bannerItems = [
  //   BannerItem(
  //       id: "1",
  //       imgUrl:
  //           "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
  //   BannerItem(
  //       id: "2",
  //       imgUrl:
  //           "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png"),
  //   BannerItem(
  //       id: "3",
  //       imgUrl:
  //           "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"),
  // ];
  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
  }

  // 分類列表
  void _getCategoryList() async {
    _categoryItems = await getCategoryListAPI();
    setState(() {});
  }

  // 輪播圖列表
  void _getBannerList() async {
    _bannerItems = await getBannerListAPI();
    setState(() {});
  }

  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: MySlider(bannerList: _bannerItems)),
      SliverToBoxAdapter(child: MyCategory(categoryItems: _categoryItems)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildren(),
    );
  }
}
