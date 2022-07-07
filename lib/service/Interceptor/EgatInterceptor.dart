import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:egattracking/dao/RefreshTokenDao.dart';
import 'package:egattracking/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repository.dart';
import '../UserService.dart';

class EgatInterceptor extends InterceptorsWrapper {
  late final Dio dio;
  late String csrfToken;
  EgatInterceptor({required this.dio});
  @override
  Future<dynamic> onError(
      DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      try {
        await refreshToken();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        RequestOptions options = error.response!.requestOptions;
        options.headers["Authorization"] =
            "Bearer ${prefs.getString(UserService.key_access_token)}";
        final opts = new Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        return MyApp.dio.request(options.path,
            options: opts,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
      } catch (e) {
        UserService.logout();
        print(e);
        return super.onError(error, handler);
      }
    } else {
      return super.onError(error, handler);
    }
  }

  Future<RefreshTokenDao> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "grant_type": "refresh_token",
      "username": prefs.getString(UserService.key_user_name),
      "refresh_token": prefs.getString(UserService.key_refresh_token)
    });
    var response = await Dio().post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    RefreshTokenDao refreshTokenDao = RefreshTokenDao.fromJson(response.data);

    if (response.statusCode! < 300) {
      prefs.setString(
          UserService.key_access_token, refreshTokenDao.accessToken);
    } else {
      prefs.setString(UserService.key_access_token, "");
    }
    return refreshTokenDao;
  }
}
