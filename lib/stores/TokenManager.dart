import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/contants/index.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = '';
  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? '';
    print("token = $_token");
  }

  Future<void> setToken(String val) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token = val;
  }

  String getToken() => _token;
  // 删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); // 磁盘
    _token = ""; // 内存
  }
}

final tokenManager = TokenManager();
