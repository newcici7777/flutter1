import 'package:shop/contants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final result =
      ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((item) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList();
  return result;
}

// 分類列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  final result =
      ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((item) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
  return result;
}

Future<SpecialRecommendResult> getProductListAPI() async {
  final result = SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_LIST),
  );
  return result;
}

Future<List<GoodDetailItem>> getRecommendListAPI(
    Map<String, dynamic> params) async {
  final result = ((await dioRequest.get(HttpConstants.RECOMMEND_LIST,
          params: params)) as List)
      .map((item) {
    return GoodDetailItem.formJSON(item as Map<String, dynamic>);
  }).toList();
  return result;
}
