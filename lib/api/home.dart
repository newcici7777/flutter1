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
