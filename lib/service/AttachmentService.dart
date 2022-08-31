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
      File? files, File? files2, String reportId) async {
    print("call attachment");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
      var userId = prefs.getString(UserService.keyuserid);
      List<AttachmentCreateDao> uploadImageResults = [];
      print("before for");
      if (true) {
        print("in for each with file = $files");
        File? file = files;
        if (file != null) {
          String fileName = file.path.split('/').last;
          var multipart =
              await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: multipart.contentType!
                    .change(type: "image", subtype: fileName.split('.').last)),
            "parentid": reportId,
            "type": "report"
          });
          var response = await MyApp.dio.post(Repository.attachment,
              data: formData,
              options: Options(headers: {
                "Authorization":
                    "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
              }));
          if (response.statusCode! < 300)
            uploadImageResults.add(AttachmentCreateDao.fromJson(response.data));
        }
      }

        if (true) {
          print("in for each with file = $files2");
          File? file = files2;
          if (file != null) {
            String fileName = file.path.split('/').last;
            var multipart =
                await MultipartFile.fromFile(file.path, filename: fileName);
            FormData formData = FormData.fromMap({
              "file": await MultipartFile.fromFile(file.path,
                  filename: fileName,
                  contentType: multipart.contentType!.change(
                      type: "image", subtype: fileName.split('.').last)),
              "parentid": reportId,
              "type": "report"
            });
            var response = await MyApp.dio.post(Repository.attachment,
                data: formData,
                options: Options(headers: {
                  "Authorization":
                      "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
                }));
            if (response.statusCode! < 300)
              uploadImageResults
                  .add(AttachmentCreateDao.fromJson(response.data));
          }
        }
      
      return uploadImageResults;
    } catch (e) {
      print("error : $e");
      return [];
    }
  }

  static Future<List<AttachmentCreateDao>> createAttachment2(
      File? files, File? files2, File? files3, File? files4, String reportId) async {
    print("call attachment");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
      var userId = prefs.getString(UserService.keyuserid);
      List<AttachmentCreateDao> uploadImageResults = [];
      print("before for");
      if (true) {
        print("in for each with file = $files");
        File? file = files;
        if (file != null) {
          String fileName = file.path.split('/').last;
          var multipart =
              await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: multipart.contentType!
                    .change(type: "image", subtype: fileName.split('.').last)),
            "parentid": reportId,
            "type": "report"
          });
          var response = await MyApp.dio.post(Repository.attachment,
              data: formData,
              options: Options(headers: {
                "Authorization":
                    "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
              }));
          if (response.statusCode! < 300)
            uploadImageResults.add(AttachmentCreateDao.fromJson(response.data));
        }
      }

        if (true) {
          print("in for each with file = $files2");
          File? file = files2;
          if (file != null) {
            String fileName = file.path.split('/').last;
            var multipart =
                await MultipartFile.fromFile(file.path, filename: fileName);
            FormData formData = FormData.fromMap({
              "file": await MultipartFile.fromFile(file.path,
                  filename: fileName,
                  contentType: multipart.contentType!.change(
                      type: "image", subtype: fileName.split('.').last)),
              "parentid": reportId,
              "type": "report"
            });
            var response = await MyApp.dio.post(Repository.attachment,
                data: formData,
                options: Options(headers: {
                  "Authorization":
                      "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
                }));
            if (response.statusCode! < 300)
              uploadImageResults
                  .add(AttachmentCreateDao.fromJson(response.data));
          }
        }
      
      if (true) {
        print("in for each with file = $files3");
        File? file = files3;
        if (file != null) {
          String fileName = file.path.split('/').last;
          var multipart =
              await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: multipart.contentType!
                    .change(type: "image", subtype: fileName.split('.').last)),
            "parentid": reportId,
            "type": "report"
          });
          var response = await MyApp.dio.post(Repository.attachment,
              data: formData,
              options: Options(headers: {
                "Authorization":
                    "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
              }));
          if (response.statusCode! < 300)
            uploadImageResults.add(AttachmentCreateDao.fromJson(response.data));
        }
      }

      if (true) {
        print("in for each with file = $files4");
        File? file = files4;
        if (file != null) {
          String fileName = file.path.split('/').last;
          var multipart =
              await MultipartFile.fromFile(file.path, filename: fileName);
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path,
                filename: fileName,
                contentType: multipart.contentType!
                    .change(type: "image", subtype: fileName.split('.').last)),
            "parentid": reportId,
            "type": "report"
          });
          var response = await MyApp.dio.post(Repository.attachment,
              data: formData,
              options: Options(headers: {
                "Authorization":
                    "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
              }));
          if (response.statusCode! < 300)
            uploadImageResults.add(AttachmentCreateDao.fromJson(response.data));
        }
      }

      return uploadImageResults;
    } catch (e) {
      print("error : $e");
      return [];
    }
  }

  

  static Future<List<AttachmentImageUrlDao>> getImageUrlFromId(
      String parentId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
      var userId = prefs.getString(UserService.keyuserid);
      var response = await MyApp.dio.get(Repository.attachmentById(parentId),
          options: Options(headers: {
            "Authorization":
                "Bearer ${prefs.getString(UserService.keyaccesstoken)}"
          }));
      if (response is String) {
        return [];
      } else {
        var mapList = response.data as List;
        return mapList.map((tmp) {
          return AttachmentImageUrlDao.fromJson(tmp);
        }).toList();
      }
    } catch (e) {
      return [];
    }
  }
}
