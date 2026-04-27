import 'package:get/get.dart';
import 'package:shop/viewmodels/user.dart';

class UserController extends GetxController {
  var userInfo = UserInfo.fromJSON({}).obs;
  // 更新用戶信息
  void updateUserInfo(UserInfo userInfo) {
    print("userinfo = $userInfo");
    this.userInfo.value = userInfo;
  }
}
