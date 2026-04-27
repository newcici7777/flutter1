import 'package:dio/dio.dart';
import 'package:shop/contants/index.dart';
import 'package:shop/stores/TokenManager.dart';

class DioRequest {
  final _dio = Dio();
  DioRequest() {
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      print("token3333 = ${tokenManager.getToken()}");
      if (tokenManager.getToken().isNotEmpty)
        request.headers = {
          "Authorization": "Bearer ${tokenManager.getToken()}"
        };
      handler.next(request);
    }, onResponse: (response, handler) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        handler.next(response);
        return;
      }
      handler.reject(DioException(requestOptions: response.requestOptions));
    }, onError: (error, handler) {
      handler.reject(DioException(
          requestOptions: error.requestOptions,
          message: error.response?.data["msg"] ?? "exception"));
    }));
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? params}) {
    print("params:" + params.toString());
    return _handleResponse(_dio.post(url, data: params));
  }

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data['code'] == GlobalConstants.SUCCESS_CODE) {
        return data["result"];
      }
      throw DioException(
          requestOptions: res.requestOptions,
          message: data["msg"] ?? "exception");
    } catch (e) {
      rethrow;
    }
  }
}

final dioRequest = DioRequest();
