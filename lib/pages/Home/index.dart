import 'package:flutter/material.dart';
import 'package:shop/api/home.dart';
import 'package:shop/contants/index.dart';
import 'package:shop/pages/Home/my_category.dart';
import 'package:shop/pages/Home/my_hasmore.dart';
import 'package:shop/pages/Home/my_slider.dart';
import 'package:shop/pages/Home/my_suggestion.dart';
import 'package:shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    _getProductList();
    _getRecommendList();
    _registerEvent();
  }

  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent - 50)) {
        _getRecommendList();
      }
    });
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

  SpecialRecommendResult _specialRecommendResult =
      SpecialRecommendResult(id: "", title: "", subTypes: []);
  // 商品列表
  void _getProductList() async {
    _specialRecommendResult = await getProductListAPI();
    setState(() {});
  }

  // 特惠推荐 - 商品列表
  List<GoodDetailItem> _recommendList = [];
  // 特惠推荐 - 商品列表
  int _pageNum = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  void _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int limit = _pageNum * 10;
    _recommendList = await getRecommendListAPI({
      "limit": limit,
      // "pageNum": 1,
      // "pageSize": 10,
    });
    _isLoading = false;
    setState(() {});
    if (_recommendList.length < limit) {
      _hasMore = false;
      return;
    }
    _pageNum++;
  }

  // 滚动列表
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: MySlider(bannerList: _bannerItems)),
      SliverToBoxAdapter(child: MyCategory(categoryItems: _categoryItems)),
      SliverToBoxAdapter(
          child: MySuggestion(specialRecommendResult: _specialRecommendResult)),
      MyMoreList(recommendList: _recommendList),
    ];
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> _refresh() async {
    print("refresh");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: _getScrollChildren(),
        ));
  }
}
