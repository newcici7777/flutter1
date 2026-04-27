import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/api/user.dart';
import 'package:shop/stores/TokenManager.dart';
import 'package:shop/stores/UserController.dart';
import 'package:shop/utils/LoadingDialog.dart';
import 'package:shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final UserController _userController = Get.find();
  Widget _buildPhoneField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "請輸入電話號碼";
          }
          if (!RegExp(r'[0-9]{10}$').hasMatch(value)) {
            return "請輸入正確的電話號碼";
          }
          return null;
        },
        controller: _phoneController,
        decoration: InputDecoration(
          hintText: "電話號碼",
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }

  Widget _buildPasswordField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "請輸入密碼";
          }
          if (!RegExp(r'^[a-zA-Z0-9]{6,}$').hasMatch(value)) {
            return "密碼長度必須為6個字元以上，且包含數字和字母的組合";
          }
          return null;
        },
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "密碼",
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }

  bool _isChecked = false;
  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        Text("記住密碼"),
      ],
    );
  }

  _login() async {
    try {
      LoadingDialog.show(context);
      // 只能使用 account 13200000001 密碼 123456 登入
      final res = await loginAPI({
        "account": _phoneController.text,
        "password": _passwordController.text
      });
      _userController.updateUserInfo(res);
      tokenManager.setToken(res.token ?? '');
      ToastUtils.show(context, "登入成功");
      Navigator.pushNamed(context, "/");
    } catch (e) {
      LoadingDialog.hide(context);
      print((e as DioException).message ?? "登入失敗");
      ToastUtils.show(context, (e as DioException).message ?? "登入失敗");
    }
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          if (_isChecked) {
            _login();
          } else {
            // 登入
          }
        }
      },
      child: Text("登入"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildPhoneField(),
              SizedBox(height: 20),
              _buildPasswordField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
