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
  // ignore: non_constant_identifier_names
  static final key_access_token = "key_access_token";
  // ignore: non_constant_identifier_names
  static final key_refresh_token = "key_refresh_token";
  // ignore: non_constant_identifier_names
  static final key_user_name = "key_user_name";
  // ignore: non_constant_identifier_names
  static final key_user_id = "key_user_id";
  // ignore: non_constant_identifier_names
  static final key_user_role = "key_user_role";

  static Future<LoginDao> login(String username, String password) async {
    final body = jsonEncode(
        {"grant_type": "password", "username": username, "password": password});
    var response = await MyApp.dio.post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    LoginDao loginDao = LoginDao.fromJson(response.data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginPage.keylogin, response.statusCode! < 300);
    print(response.statusCode);
    if (response.statusCode! < 300) {
      prefs.setString(key_access_token, loginDao.accessToken);
      prefs.setString(key_refresh_token, loginDao.refreshToken);
      prefs.setString(key_user_name, username);
      prefs.setString(key_user_id, loginDao.uid);
      prefs.setString(key_user_role, loginDao.role);
    }
    return loginDao;
  }

  static Future<RefreshTokenDao> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "grant_type": "refresh_token",
      "username": prefs.getString(key_user_name),
      "refresh_token": prefs.getString(key_refresh_token)
    });

    var response = await MyApp.dio.post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    RefreshTokenDao refreshTokenDao = RefreshTokenDao.fromJson(response.data);

    if (response.statusCode! < 300) {
      prefs.setString(key_access_token, refreshTokenDao.accessToken);
    }
    return refreshTokenDao;
  }
  static Future<ProfileDao> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await MyApp.dio.get(
        Repository.profile(prefs.getString('key_user_id')!),
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString(key_access_token)}"
        }));
    if(response.statusCode! > 300){
      var refresh = await refreshToken();
      var responseNew = await MyApp.dio.get(
          Repository.profile(prefs.getString(key_user_id)!),
          options: Options(headers: {
            "Authorization": "Bearer ${refresh.accessToken}"
          }));
      return ProfileDao.fromJson(responseNew.data);
    }else return ProfileDao.fromJson(response.data);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginPage.keylogin, false);
    prefs.setString(key_access_token, "");
    prefs.setString(key_refresh_token, "");
    prefs.setString(key_user_name, "");
    prefs.setString(key_user_id, "");
  }

  static void test401() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key_access_token, "");
  }

  static Future<UploadImagesDao> uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(UserService.key_user_id);
    String fileName = file.path
        .split('/')
        .last;
    var multipart = await MultipartFile.fromFile(file.path, filename: fileName);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName,
          contentType: multipart.contentType!.change(
              type: "image", subtype: fileName
              .split('.')
              .last))
    });
    var response = await MyApp.dio.put(
        Repository.uploadImage(userId!), data: formData, options:
    Options(headers: {
      "Authorization": "Bearer ${prefs.getString(
          UserService.key_access_token)}"
    }));

    return UploadImagesDao.fromJson(response.data);
  }
}
