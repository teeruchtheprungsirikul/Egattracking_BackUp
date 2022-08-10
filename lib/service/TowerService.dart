import 'package:dio/dio.dart';
import 'package:egattracking/dao/TowerDao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Repository.dart';
import 'UserService.dart';

class TowerService {

  static Future<TowerDao> getTower() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await MyApp.dio.get(
        Repository.getTowerPaging(100, 1),
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization":
          "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
        }));
    return TowerDao.fromJson(response.data);
  }

  static Future<TowerDao> getTowerInRang(double latitude,double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await MyApp.dio.get(
        Repository.getTowerInRange(20, latitude, longitude),
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization":
          "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
        }));
    return TowerDao.fromJson(response.data);
  }
}