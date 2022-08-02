import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
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
  
  static final keyaccesstoken = "KEY_ACCESS_TOKEN";
 
  static final keyrefreshtoken = "KEY_REFRESH_TOKEN";
  
  static final keyusername = "KEY_USER_NAME";
  
  static final keyuserid = "KEY_USER_ID";
  
  static final keyuserrole = "KEY_USER_ROLE";

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
      prefs.setString(keyaccesstoken, loginDao.accessToken);
      prefs.setString(keyrefreshtoken, loginDao.refreshToken);
      prefs.setString(keyusername, username);
      prefs.setString(keyuserid, loginDao.uid);
      prefs.setString(keyuserrole, loginDao.role);
    }
    return loginDao;
  }

  static Future<RefreshTokenDao> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "grant_type": "refresh_token",
      "username": prefs.getString(keyusername),
      "refresh_token": prefs.getString(keyrefreshtoken)
    });

    var response = await MyApp.dio.post(Repository.login,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: body);
    RefreshTokenDao refreshTokenDao = RefreshTokenDao.fromJson(response.data);

    if (response.statusCode! < 300) {
      prefs.setString(keyaccesstoken, refreshTokenDao.accessToken);
    }
    return refreshTokenDao;
  }
  static Future<ProfileDao> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await MyApp.dio.get(
        Repository.profile(prefs.getString('keyuserid')!),
        options: Options(headers: {
          "Authorization": "Bearer ${prefs.getString(keyaccesstoken)}"
        }));
    if(response.statusCode! > 300){
      var refresh = await refreshToken();
      var responseNew = await MyApp.dio.get(
          Repository.profile(prefs.getString(keyuserid)!),
          options: Options(headers: {
            "Authorization": "Bearer ${refresh.accessToken}"
          }));
      return ProfileDao.fromJson(responseNew.data);
    }else return ProfileDao.fromJson(response.data);
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginPage.keylogin, false);
    prefs.setString(keyaccesstoken, "");
    prefs.setString(keyrefreshtoken, "");
    prefs.setString(keyusername, "");
    prefs.setString(keyuserid, "");
  }

  static void test401() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyaccesstoken, "");
  }

  static Future<UploadImagesDao> uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(UserService.keyuserid);
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
          UserService.keyaccesstoken)}"
    }));

    return UploadImagesDao.fromJson(response.data);
  }
}
