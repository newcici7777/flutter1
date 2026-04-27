import 'package:flutter/material.dart';
import 'package:shop/api/home.dart';
import 'package:shop/contants/index.dart';
import 'package:shop/pages/Home/my_category.dart';
import 'package:shop/pages/Home/my_hasmore.dart';
import 'package:shop/pages/Home/my_slider.dart';
import 'package:shop/pages/Home/my_suggestion.dart';
import 'package:shop/utils/ToastUtils.dart';
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
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _refreshIndicatorKey.currentState?.show();
    });
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
  Future<void> _getCategoryList() async {
    _categoryItems = await getCategoryListAPI();
  }

  // 輪播圖列表
  Future<void> _getBannerList() async {
    _bannerItems = await getBannerListAPI();
  }

  SpecialRecommendResult _specialRecommendResult =
      SpecialRecommendResult(id: "", title: "", subTypes: []);
  // 商品列表
  Future<void> _getProductList() async {
    _specialRecommendResult = await getProductListAPI();
  }

  // 特惠推荐 - 商品列表
  List<GoodDetailItem> _recommendList = [];
  // 特惠推荐 - 商品列表
  int _pageNum = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  Future<void> _getRecommendList() async {
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
    _pageNum = 1;
    _hasMore = true;
    _isLoading = false;
    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getRecommendList();
    ToastUtils.show(context, "Loading success");
    _paddingTop = 0;
    setState(() {});
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: _refresh,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.only(top: _paddingTop),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: _getScrollChildren(),
          ),
        ));
  }
}
