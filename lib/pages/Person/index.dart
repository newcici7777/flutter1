import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/stores/TokenManager.dart';
import 'package:shop/stores/UserController.dart';
import 'package:shop/utils/LoadingDialog.dart';
import 'package:shop/viewmodels/user.dart';

class PersonView extends StatefulWidget {
  PersonView({Key? key}) : super(key: key);

  @override
  _PersonViewStateState createState() => _PersonViewStateState();
}

class _PersonViewStateState extends State<PersonView> {
  final UserController _userController = Get.find();
  Widget _getLogout() {
    return _userController.userInfo.value.id.isNotEmpty
        ? GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("登出"),
                      content: Text("确定登出吗？"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await tokenManager.removeToken();
                            _userController
                                .updateUserInfo(UserInfo.fromJSON({}));
                            Navigator.pop(context);
                          },
                          child: Text("确定"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("取消"),
                        ),
                      ],
                    );
                  });
            },
            child: Text("登出"),
          )
        : Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(() {
            return GestureDetector(
              onTap: () {
                if (_userController.userInfo.value.id.isEmpty) {
                  Navigator.pushNamed(context, "/login");
                }
              },
              child: Text(_userController.userInfo.value.id.isNotEmpty
                  ? _userController.userInfo.value.account
                  : "登入"),
            );
          }),
          Obx(() => _getLogout()),
        ],
      ),
    );
  }
}
