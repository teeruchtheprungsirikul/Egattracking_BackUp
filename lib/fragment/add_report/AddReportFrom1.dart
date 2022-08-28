
import 'package:egattracking/Single.dart';
import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/fragment/BaseStatefulState.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormDifficultySection.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import 'SendReportUseCase.dart';

class AddReportForm1 extends StatefulWidget {
  final ReportDao? reportDao;
  AddReportForm1({Key? key, this.reportDao}) : super(key: key);
  // AddReportForm1({ReportDao? reportDao});

  @override
  MyCustomAddReportForm1State createState() {
    return MyCustomAddReportForm1State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.

class MyCustomAddReportForm1State extends BaseStatefulState<AddReportForm1> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm1State({ReportDao? reportDao}) {
    //this.reportDao = reportDao;
    this.reportDao = ReportDao(id: "", towerId: "", type: "");
  }
  
  late Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);
  late FormDifficultySection formDifficultySection;

  List<String> topic = Topic.report1;
  late List<TextEditingController> mEditingController;
  Single? mSingle = MyApp.mfactory.newInstant();

  @override
  void initState() {
    _profile = UserService.getProfile();
    mEditingController =
        List.generate(topic.length, (i) => TextEditingController());
//     mEditingController =
//         List<int>.filled
//  (topic.length, 0).cast<TextEditingController>();
    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }
    if (this.reportDao!.id == "") {
      mEditingController[0].text = MyApp.tower!.name;
      mEditingController[1].text = MyApp.tower!.type;
    }
    formDifficultySection = FormDifficultySection(this.reportDao!);
    for (var i = 0; i < formDifficultySection.checkBoxValue.length; i++) {
      formDifficultySection.checkBoxValue[i] =
          initialText(Topic.warningBreak[i]) == "true";
    }
    formDifficultySection.checkBoxUrgentValue[0] =
        initialText(Topic.urgent[0]) == "true";
    urgent = initialText(Topic.urgent[0])!;
    if (urgent.isEmpty) urgent = "ไม่เร่งด่วน";
    super.initState();
  }

  String? initialText(String key) {
    if (this.reportDao == null)
      return "";
    else {
      try {
        return this.reportDao!.values!.firstWhere((it) => it.key == key).value;
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
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            child: Text(
                              "ตรวจสอบสายส่งโดยการเดินตรวจ",
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
                              return FromUserSection(data.firstname, data.team,
                                  snapshot.data!.imageUrl!);
                            }
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.yellow),
                            ));
                          }),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[0],
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "สายส่ง",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกสายส่ง",
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
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[1],
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: "No เสาที่ส่ง",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกเลขเสา",
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
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[2],
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "ระยะทางสะสม",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอก % สะสม",
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
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: mEditingController[3],
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "ปัญหาที่สำคัญที่พบเจอ",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกรายละเอียด",
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
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        child: TextFormField(
                          controller: mEditingController[4],
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: "หมายเหตุ",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(),
                            ),
                            hintText: "กรอกรายละเอียด",
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            return null;
                          },
                        ),
                      ),
                      formDifficultySection.provideTitle("สิ่งรุกล้ำป้ายเตือน"),
                      for (var i = 0; i < 6; i++)
                        provideCheckboxBreakWarning(i),
                      formDifficultySection,
                      formDifficultySection.provideTitle("เร่งด่วน"),
                      dropdownUrgent(),
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
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.amberAccent,
                                    textStyle: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    List<Map> body = [];
                                    var towerNo = this.reportDao!.towerId != ""
                                        ? this.reportDao!.towerId
                                        : MyApp.tower!.id;
                                    body.add({
                                      "key": "name",
                                      "type": "string",
                                      "value": "ตรวจสอบสายส่งโดยการตรวจเดิน"
                                    });
                                    body.add({
                                      "key": Topic.urgent[0],
                                      "type": "string",
                                      "value": urgent
                                    });
                                    for (var i = 0; i < topic.length; i++) {
                                      body.add({
                                        "key": topic[i],
                                        "type": "string",
                                        "value": mEditingController[i].text
                                      });
                                    }
                                    body.addAll(formDifficultySection
                                        .getValueForPost());
                                    var oj = ObjectRequestSendReport(
                                        body, "1", towerNo!, this.reportDao!);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.yellow),
                                                ),
                                              ),
                                            ));
                                    SendReportUseCase.serReport(oj, (response) {
                                      sentAttechment(response);
                                    });
                                  }
                                },
                                child: Text('บันทึก'),
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

  CheckboxListTile provideCheckboxBreakWarning(int index) {
    return CheckboxListTile(
      title: Text(formDifficultySection.labelCheckboxWarning[index]),
      value: formDifficultySection.checkBoxValue[index],
      onChanged: (isCheck) {
        setState(() {
          formDifficultySection.checkBoxValue[index] = isCheck!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  CheckboxListTile provideCheckboxUrgent(int index) {
    return CheckboxListTile(
      title: Text(formDifficultySection.labelCheckboxUrgent[index]),
      value: formDifficultySection.checkBoxUrgentValue[index],
      onChanged: (isCheck) {
        setState(() {
          formDifficultySection.checkBoxUrgentValue[index] = isCheck!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
