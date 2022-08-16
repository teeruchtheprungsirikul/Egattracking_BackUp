import 'dart:io';

import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/service/AttachmentService.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import 'SendReportUseCase.dart';

class AddReportForm24 extends StatefulWidget {
  final reportDao;

  AddReportForm24({Key? key, this.reportDao}) : super(key: key);

  @override
  MyCustomAddReportForm24State createState() {
    return MyCustomAddReportForm24State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomAddReportForm24State extends State<AddReportForm24> {
  late ReportDao? reportDao;
  late DateTime _timeChoose;
  late List<File> _file;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm24State({ReportDao? reportDao}) {
    this.reportDao = reportDao!;
  }

  late Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);

  List<String> topic = Topic.report24;
  late List<TextEditingController> mEditingController;

  @override
  void initState() {
    _profile = UserService.getProfile();
    _timeChoose = DateTime.now();
    _file = List<int>.filled(4, 0).cast<File>();
    List<int>.filled(topic.length, 0).cast<TextEditingController>();

    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }
    super.initState();
  }

  String? initialText(String key) {
    if (reportDao == null)
      return "";
    else {
      try {
        return reportDao!.values.firstWhere((it) => it.key == key).value;
      } catch (error) {
        return "";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    DateTime now = DateTime.now();
    String today = DateFormat.yMd().format(now);
    String time = DateFormat.Hm().format(now);

    return SafeArea(
        child: Scaffold(
            body: Builder(
                builder: (context) => Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Text(
                                    "รูปภาพการปฏิบัติงาน",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 8.0, 0.0, 0.0),
                                  child: Text("ในหมวด",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black38)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 8.0, 0.0, 0.0),
                                  child: Text("งานบำรุงรักษาเชิงป้องกัน (PM)",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ),
                              ],
                            ),
                            FutureBuilder(
                                future: _profile,
                                builder: (BuildContext context,
                                    AsyncSnapshot<ProfileDao> snapshot) {
                                  if (snapshot.hasData) {
                                    ProfileDao data = snapshot.data!;
                                    return FromUserSection(data.firstname,
                                        data.team, snapshot.data!.imageUrl!);
                                  }
                                  return Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.yellow)));
                                }),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[0],
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: "สังกัดหน่วย",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกหน่วย",
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val!.length == 0)
                                    return "โปรดกรอกข้อความ";
                                  else
                                    return null;
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  child: Text(
                                    DateFormat("dd/MM/yyyy HH:mm")
                                        .format(_timeChoose),
                                  ),
                                  onPressed: () {
                                    DatePicker.showDateTimePicker(context,
                                        currentTime: _timeChoose,
                                        onConfirm: (time) {
                                      setState(() {
                                        _timeChoose = time;
                                      });
                                    },
                                        showTitleActions: true,
                                        locale: LocaleType.th
                                      );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    textStyle: TextStyle(color: Colors.black),
                                    shape: StadiumBorder(),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GridView.count(
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(_file[0], 0),
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(_file[1], 1),
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
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(_file[2], 2),
                                          ),
                                        ),
                                      ))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Material(
                                          child: InkWell(
                                        onTap: () {
                                          getImage(3);
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(_file[3], 3),
                                          ),
                                        ),
                                      ))),
                                ]),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[1],
                                decoration: InputDecoration(
                                  labelText: "คำอธิบาย",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกคำอธิบาย",
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val!.length == 0)
                                    return "โปรดกรอกข้อความ";
                                  else
                                    return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
            bottomNavigationBar: Container(
              height: 87.0,
              child: Column(
                children: <Widget>[
                  Divider(color: Colors.grey),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 0.0, 8.0),
                              child: Text("วันที่บันทึก",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 0.0, 8.0),
                              child: Text(today,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            )
                          ],
                        ),
                      )),
                      Flexible(
                          child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 0.0, 8.0),
                              child: Text("เวลา",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black38)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 0.0, 8.0),
                              child: Text(time,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            )
                          ],
                        ),
                      )),
                      Flexible(
                        child: Padding(
                          padding: childPadding,
                          child: ElevatedButton(
                            child: Text('บันทึก'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.amberAccent,
                                textStyle: TextStyle(color: Colors.white)),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState!.validate()) {
                                List<Map> body = [];
                                var towerNo = reportDao != null
                                    ? reportDao!.towerId
                                    : MyApp.tower.id;
                                body.add({
                                  "key": "name",
                                  "type": "string",
                                  "value": "รูปภาพการปฏิบัติงาน"
                                });
                                for (var i = 0; i < topic.length; i++) {
                                  body.add({
                                    "key": topic[i],
                                    "type": "string",
                                    "value": mEditingController[i].text
                                  });
                                }
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => Container(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.yellow)),
                                          ),
                                        ));

                                var oj = ObjectRequestSendReport(
                                    body, "24", towerNo, reportDao!);

                                SendReportUseCase.serReport(oj, (response) {
                                  if (response.code! < 300) {
                                    AttachmentService.createAttachment(
                                            _file, response.reportId!)
                                        .then((attacresponse) {
                                      sendDone(context, response);
                                    });
                                  } else
                                    sendDone(context, response);
                                });
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  void sendDone(BuildContext context, PostReportDao response) {
    Navigator.of(context).popUntil((route) => route.isFirst);
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

  Future getImage(index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(image!.path);
    setState(() {
      _file[index] = File(image.path);
    });
  }
}
