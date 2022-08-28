import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/dao/UploadImagesDao.dart';
import 'package:egattracking/service/AttachmentService.dart';
import 'package:egattracking/service/Repository.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ReportService {
  static Future<PostReportDao> sendReport(List<Map> data, String type, String towerNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(UserService.keyuserid);
    var body = {
      "type": type,
      "tower_id": towerNo,
      "created_by": userId,
      "modified_by": userId,
      "values": data};
    var response = await MyApp.dio.post(Repository.report,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization":
          "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
        }),
        data: jsonEncode(body));
    return PostReportDao.fromJson(response.data);
  }

  static Future<PostReportDao> editReport(List<Map> data, String type,
      String towerNo, String reportId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(UserService.keyuserid);
    var body = {
      "type": type,
      "tower_id": towerNo,
      "modified_by": userId,
      "id": reportId,
      "values": data};
    var response = await MyApp.dio.put(Repository.putReport(reportId),
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
          "Content-Type": "application/json;charset=UTF-8 ",
          "Authorization":
          "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
        }),
        data: jsonEncode(body));
    return PostReportDao.fromJson(response.data);
  }

  static Future<List<ReportDao>> getReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String reportUrl;
    if (prefs.getString(UserService.keyuserrole) == "admin") {
      reportUrl = Repository.report;
    } else {
      reportUrl =
          Repository.getReport(prefs.getString(UserService.keyuserid).toString());
    }
    var response = await MyApp.dio.get(
        reportUrl,
        options: Options(headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization":
          "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
        }));
    if (response.data is String) {
       return <ReportDao>[];
    } else {
      var mapList = response.data as List;
      var result = mapList.map((item) => ReportDao.fromJson(item)).toList();
      var map = Map<String, List<String>>();

      for (var s in result) {
          var images = await AttachmentService.getImageUrlFromId(s.id!);
          map[s.id!] = images.map((t) => t.url).toList();
      }
      var result2 = result.map((tmp) {
          tmp.images = map[tmp.id]!;
        return tmp;
      }).toList();

      result2.sort((A, B) {
        return A.modifiedOn!.compareTo(B.modifiedOn!);
      });
      return result2.reversed.toList();
    }
  }

  static Future<List<UploadImagesDao>> uploadImages(List<File?> files) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString(UserService.keyuserid);
      List<UploadImagesDao> uploadImageResults = [];
      for (var file in files) {
        if (file != null) {
          String fileName = file.path
              .split('/')
              .last;
          var multipart = await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "image": await MultipartFile.fromFile(file.path, filename: fileName,contentType: multipart.contentType?.change(type: "image",subtype: fileName.split('.').last))
          });
          var response = await MyApp.dio.put(
              Repository.uploadImage(userId!), data: formData, options:
          Options(headers: {
            "Content-Type": "multipart/form-data; boundary=----WebKitFormBoundaryyrV7KO0BoCBuDbTL",
            "Authorization": "Bearer ${prefs.getString(
                UserService.keyaccesstoken)}"
          }));
          if (response.statusCode! < 300) uploadImageResults.add(UploadImagesDao.fromJson(response.data));
        }
      }
      return uploadImageResults;
    }catch(e){
      return [];
    }
  }
}