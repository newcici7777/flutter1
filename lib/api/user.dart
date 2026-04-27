import 'package:shop/contants/index.dart';
import 'package:shop/utils/DioRequest.dart';
import 'package:shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  return UserInfo.fromJSON(
      await dioRequest.post(HttpConstants.LOGIN, params: params));
}

// acount 跟密碼只能使用下方練習
//  curl -X POST "https://meikou-api.itheima.net/login" \
// -H "Content-Type: application/json" \
// -d '{
//   "account": "13200000001",
//   "password": "123456"
// }'
Future<UserInfo> getUserProfileAPI() async {
  return UserInfo.fromJSON(await dioRequest.get(HttpConstants.USER_PROFILE));
}
