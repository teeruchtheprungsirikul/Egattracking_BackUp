import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egattracking/dao/LogInDao.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/RefreshTokenDao.dart';
import 'package:egattracking/dao/UploadImagesDao.dart';
import 'package:egattracking/fragment/login_page.dart';
import 'package:egattracking/main.dart';
import 'package:egattracking/service/Repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static final KEY_ACCESS_TOKEN = "KEY_ACCESS_TOKEN";
  static final KEY_REFRESH_TOKEN = "KEY_REFRESH_TOKEN";
  static final KEY_USER_NAME = "KEY_USER_NAME";
  static final KEY_USER_ID = "KEY_USER_ID";
  static final KEY_USER_ROLE = "KEY_USER_ROLE";

  static Future<LoginDao> login(String username, String password) async {
    final body = jsonEncode(
        {"grant_type": "password", "username": username, "password": password});
    var response = await MyApp.dio.post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    LoginDao loginDao = LoginDao.fromJson(response.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginPage.KEY_IS_LOGIN, response.statusCode < 300);
    print(response.statusCode);
    if (response.statusCode < 300) {
      prefs.setString(KEY_ACCESS_TOKEN, loginDao.accessToken);
      prefs.setString(KEY_REFRESH_TOKEN, loginDao.refreshToken);
      prefs.setString(KEY_USER_NAME, username);
      prefs.setString(KEY_USER_ID, loginDao.uid);
      prefs.setString(KEY_USER_ROLE, loginDao.role);
    }
    return loginDao;
  }

  static Future<RefreshTokenDao> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "grant_type": "refresh_token",
      "username": prefs.getString(KEY_USER_NAME),
      "refresh_token": prefs.getString(KEY_REFRESH_TOKEN)
    });

    var response = await MyApp.dio.post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    RefreshTokenDao refreshTokenDao = RefreshTokenDao.fromJson(response.data);

    if (response.statusCode < 300) {
      prefs.setString(KEY_ACCESS_TOKEN, refreshTokenDao.accessToken);
    }
    return refreshTokenDao;
  }
  static Future<ProfileDao> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await MyApp.dio.get(
        Repository.profile(prefs.getString(KEY_USER_ID)),
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString(KEY_ACCESS_TOKEN)}"
        }));
    if(response.statusCode > 300){
      var refresh = await refreshToken();
      var responseNew = await MyApp.dio.get(
          Repository.profile(prefs.getString(KEY_USER_ID)),
          options: Options(headers: {
            "Authorization": "Bearer ${refresh.accessToken}"
          }));
      return ProfileDao.fromJson(responseNew.data);
    }else return ProfileDao.fromJson(response.data);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginPage.KEY_IS_LOGIN, false);
    prefs.setString(KEY_ACCESS_TOKEN, "");
    prefs.setString(KEY_REFRESH_TOKEN, "");
    prefs.setString(KEY_USER_NAME, "");
    prefs.setString(KEY_USER_ID, "");
  }

  static void test401() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_ACCESS_TOKEN, "");
  }

  static Future<UploadImagesDao> uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(UserService.KEY_USER_ID);
    String fileName = file.path
        .split('/')
        .last;
    var multipart = await MultipartFile.fromFile(file.path, filename: fileName);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName,
          contentType: multipart.contentType.change(
              type: "image", subtype: fileName
              .split('.')
              .last))
    });
    var response = await MyApp.dio.put(
        Repository.uploadImage(userId), data: formData, options:
    Options(headers: {
      "Authorization": "Bearer ${prefs.getString(
          UserService.KEY_ACCESS_TOKEN)}"
    }));

    return UploadImagesDao.fromJson(response.data);
  }
}
