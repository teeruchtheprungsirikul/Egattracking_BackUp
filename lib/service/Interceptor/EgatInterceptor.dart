import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:egattracking/dao/RefreshTokenDao.dart';
import 'package:egattracking/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Repository.dart';
import '../UserService.dart';

class EgatInterceptor extends InterceptorsWrapper {
  @override
  Future onError(DioError error) async {
    switch (error.response.statusCode) {
      case 401:
        {
          try {
            await refreshToken();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            RequestOptions options = error.response.request;
            options.headers["Authorization"] =
                "Bearer ${prefs.getString(UserService.KEY_ACCESS_TOKEN)}";
            return MyApp.dio.request(options.path, options: options);
          } catch (e) {
            UserService.logout();
            print(e);
            return super.onError(error);
          }
        }
        break;
      default:
        {
          return super.onError(error);
        }
    }
  }

  Future<RefreshTokenDao> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "grant_type": "refresh_token",
      "username": prefs.getString(UserService.KEY_USER_NAME),
      "refresh_token": prefs.getString(UserService.KEY_REFRESH_TOKEN)
    });
    var response = await Dio().post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    RefreshTokenDao refreshTokenDao = RefreshTokenDao.fromJson(response.data);

    if (response.statusCode < 300) {
      prefs.setString(
          UserService.KEY_ACCESS_TOKEN, refreshTokenDao.accessToken);
    } else {
      prefs.setString(UserService.KEY_ACCESS_TOKEN, "");
    }
    return refreshTokenDao;
  }
}
