import 'package:shop/contants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  return UserInfo.fromJSON(
      await DioRequest().post(HttpConstants.LOGIN, params: params));
}
