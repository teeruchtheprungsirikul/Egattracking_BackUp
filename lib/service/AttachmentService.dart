import 'dart:io';

import 'package:dio/dio.dart';
import 'package:egattracking/dao/AttachmentCreateDao.dart';
import 'package:egattracking/dao/AttachmentImageUrlDao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Repository.dart';
import 'UserService.dart';

class AttachmentService {
  static Future<List<AttachmentCreateDao>> createAttachment(
      List<File> files, String reportId) async {
    print("call attachment");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString(UserService.KEY_USER_ID);
      List<AttachmentCreateDao> uploadImageResults = List();
      print("before for");
      for (var file in files) {
        print("in for each with file = $file");
        if (file != null) {
          String fileName = file.path.split('/').last;
          var multipart =
              await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: multipart.contentType
                    .change(type: "image", subtype: fileName.split('.').last)),
            "parentid": reportId,
            "type": "report"
          });
          var response = await MyApp.dio.post(Repository.attachment,
              data: formData,
              options: Options(headers: {
                "Authorization":
                    "Bearer ${prefs.getString(UserService.KEY_ACCESS_TOKEN)}"
              }));
          if (response.statusCode < 300)
            uploadImageResults.add(AttachmentCreateDao.fromJson(response.data));
        }
      }
      return uploadImageResults;
    } catch (e) {
      print("error : $e");
      return List();
    }
  }

  static Future<List<AttachmentImageUrlDao>> getImageUrlFromId(
      String parentId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString(UserService.KEY_USER_ID);
      var response = await MyApp.dio.get(Repository.attachmentById(parentId),
          options: Options(headers: {
            "Authorization":
                "Bearer ${prefs.getString(UserService.KEY_ACCESS_TOKEN)}"
          }));
      if(response is String){
        return List();
      }else{
        var mapList = response.data as List;
        return mapList.map((tmp){
          return AttachmentImageUrlDao.fromJson(tmp);
        }).toList();
      }
    } catch (e) {
      return List();
    }
  }
}
