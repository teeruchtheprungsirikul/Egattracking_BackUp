import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../BaseStatefulState.dart';
import 'SendReportUseCase.dart';

class AddReportForm21 extends StatefulWidget {
  final reportDao;

  AddReportForm21({Key? key, this.reportDao}) : super(key: key);

  @override
  MyCustomAddReportForm21State createState() {
    return MyCustomAddReportForm21State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomAddReportForm21State extends BaseStatefulState<AddReportForm21> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm21State({ReportDao? reportDao}) {
    this.reportDao = reportDao;
  }
  late Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);
  late List<TextEditingController> mEditingController;

  List<String> topic = Topic.report21;

  @override
  void initState() {
    _profile = UserService.getProfile();
    List<int>.filled
 (topic.length, 0).cast<TextEditingController>();

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
    List<int>.filled
 (topic.length, 0).cast<TextEditingController>();

    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }

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
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Text(
                              "ระบบคุณภาพ ISO 9001 : 2000",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                            child: Text("ในหมวด",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black38)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(5.0, 8.0, 0.0, 0.0),
                            child: Text("การดำเนินงานด้านเพิ่มผลผลิต",
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
                              return FromUserSection(data.firstname, data.team,
                                  snapshot.data!.imageUrl!);
                            }
                            return Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.yellow)));
                          }),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Text("สรุปใบ NCR(Notif.),CAR, PAR",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                            hintText: "หน่วย",
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
                            const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Text("NCR(Notif.)",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[1],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ออก",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[2],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ปิด",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[3],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ค้าง",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[4],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "สะสม",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Text("CAR",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[5],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ออก",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[6],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ปิด",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[7],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ค้าง",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[8],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "สะสม",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Text("PAR",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[9],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ออก",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[10],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ปิด",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[11],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ค้าง",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(8.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[12],
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "สะสม",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกจำนวน",
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
                          )
                        ],
                      ),
                      imageSection(),
                      Divider(
                        color: Colors.grey,
                      ),
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
                                      "value": "ระบบคุณภาพ ISO 9001 : 2000"
                                    });
                                    body.add({
                                      "key": "wire_no",
                                      "type": "string",
                                      "value": ""
                                    });
                                    for (var i = 0; i < topic.length; i++) {
                                      body.add({
                                        "key": topic[i],
                                        "type": "string",
                                        "value": mEditingController[i].text
                                      });
                                    }

                                    var oj = ObjectRequestSendReport(
                                        body, "21", towerNo, reportDao!);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Container(
                                              width: 40,
                                              height: 40,
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.yellow)),
                                            ));
                                    SendReportUseCase.serReport(oj, (response) {
                                      sentAttechment(response);
                                    });
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    ));
  }
}
