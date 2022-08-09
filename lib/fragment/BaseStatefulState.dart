import 'dart:core';
import 'dart:io';

import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/service/AttachmentService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  // List<File> file = factory as List<File>;
  // filled(length, fill, {bool growable = false});

  List<File> file = List<int>.filled(2,0).cast<File>();
  //List<int> file = List<int>.filled(2, 0);
  late ReportDao? reportDao;
  String urgent = "ไม่เร่งด่วน";

  Widget imageSection() {
    return GridView.count(
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8),
              child: Material(
                  child: InkWell(
                onTap: () {
                  getImage(0);
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: prepareImage(file[0], 0),
                  ),
                ),
              ))),
          Container(
              padding: const EdgeInsets.all(8),
              child: Material(
                  child: InkWell(
                onTap: () {
                  getImage(1);
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: prepareImage(file[1], 1),
                  ),
                ),
              ))),
              Container(
              padding: const EdgeInsets.all(8),
              child: Material(
                  child: InkWell(
                onTap: () {
                  getImage(2);
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: prepareImage(file[2], 2),
                  ),
                ),
              )))
        ]);
  }

  Future getImage(index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image!.path);
    setState(() {
      file[index] = File(image.path);
    });
  }

  void sentAttechment(PostReportDao response) {
    if (response.code! < 300) {
      AttachmentService.createAttachment(file, response.reportId!)
          .then((attacresponse) {
        sendDone(context, response);
      });
    } else
      sendDone(context, response);
  }

  Widget dropdownUrgent() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Container(
          width: double.infinity,
          child: DropdownButton<String>(
            value: urgent,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                urgent = newValue!;
              });
            },
            items: <String>[
              'ไม่เร่งด่วน',
              'เร่งด่วนระดับ 1',
              'เร่งด่วนระดับ 2',
              'เร่งด่วนระดับ 3',
              'เร่งด่วนระดับ 4'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }

  Widget prepareImage(file, int position) {
    if (file == null) {
      try {
        var url = reportDao!.images[position];
        return Image.network(url);
      } catch (e) {
        return Image.asset(
          "assets/placeholder.png",
          fit: BoxFit.fitHeight,
        );
      }
    } else
      return Image.file(
        file,
        fit: BoxFit.fitHeight,
      );
  }

  void sendDone(BuildContext context, PostReportDao response) {
    mShowDialog(response.code! > 300, context);
  }

  void mShowDialog(
    bool isError,
    BuildContext mContext,
  ) {
    showDialog(
      context: mContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("ผลบันทึกรายงาน"),
          content: Text(isError ? "เกิดข้อผิดพลาดกรุณาลองอีกครั้ง" : "สำเร็จ"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("ปิด"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
