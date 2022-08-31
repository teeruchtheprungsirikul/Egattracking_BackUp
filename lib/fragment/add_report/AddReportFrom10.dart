import 'dart:io';
import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/fragment/add_report/SendReportUseCase.dart';
import 'package:egattracking/main.dart';
import 'package:egattracking/service/AttachmentService.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:egattracking/view/FormUserSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddReportForm10 extends StatefulWidget {
  final ReportDao? reportDao;

  AddReportForm10({Key? key, this.reportDao}) : super(key: key);

  @override
  MyCustomAddReportForm10State createState() {
    return MyCustomAddReportForm10State(reportDao: reportDao);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomAddReportForm10State extends State<AddReportForm10> {
  ReportDao? reportDao;
  DateTime? _timeChoose;
  DateTime? _dateChoose;
  DateTime? _timeChoose2;
  DateTime? _dateChoose2;
  File? _selectedImageFile1;
  File? _selectedImageFile2;
  File? _selectedImageFile3;
  File? _selectedImageFile4;
  //List<File> _file;
  String? dropdownTripValue;
  String? dropdownFixedValue;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  MyCustomAddReportForm10State({ReportDao? reportDao}) {
    this.reportDao = ReportDao(id: "", towerId: "", type: "");
  }

  late Future<ProfileDao> _profile;
  final _formKey = GlobalKey<FormState>();
  final childPadding = const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0);

  List<String> topic = Topic.report25;
  late List<TextEditingController> mEditingController;
  late List<String> _problem;

  @override
  void initState() {
    _profile = UserService.getProfile();
    _timeChoose = DateTime.now();
    _dateChoose = DateTime.now();
    _timeChoose2 = DateTime.now();
    _dateChoose2 = DateTime.now();
    _problem = [];
    dropdownTripValue = "เลือกทริป";
    dropdownFixedValue = "ดำเนินการทันที";
    mEditingController =
        List.generate(topic.length, (i) => TextEditingController());
    for (var i = 0; i < topic.length; i++) {
      mEditingController[i] =
          TextEditingController(text: initialText(topic[i]));
    }
    if (reportDao!.id == "") {
      mEditingController[0].text = MyApp.tower!.name;
    } else {
      try {
        if (initialText("problem")!.isNotEmpty) {
          _problem = initialText("problem")!.split(",");
          mEditingController[12].text = "";
        }
      } catch (e) {}
    }
    super.initState();
  }

  String? initialText(String key) {
    if (reportDao == null)
      return "";
    else {
      try {
        return reportDao!.values!.firstWhere((it) => it.key == key).value;
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
                                    "งานตรวจหาสาเหตุสายขัดข้อง",
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
                                  child: Text("งานบำรุงรักษาแบบแก้ไข(cm)",
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
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.yellow),
                                    ),
                                  );
                                }),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[1],
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: "ช่วง",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกช่วง",
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
                              child: TextFormField(
                                controller: mEditingController[2],
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: "วงจร",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกวงจร",
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
                              child: Text("trip วันที่",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 0.0, 0.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          DatePicker.showDatePicker(context,
                                              currentTime: _dateChoose,
                                              onConfirm: (time) {
                                            setState(() {
                                              _dateChoose = time;
                                            });
                                          },
                                              showTitleActions: true,
                                              locale: LocaleType.th)
                                        },
                                        style: OutlinedButton.styleFrom(
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          side: BorderSide(
                                              color: Colors.grey,
                                              width: 2.0,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Text(
                                          DateFormat("dd/MM/yyyy")
                                              .format(_dateChoose!),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 20.0, 20.0, 0.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          DatePicker.showTimePicker(context,
                                              currentTime: _timeChoose,
                                              onConfirm: (time) {
                                            setState(() {
                                              _timeChoose = time;
                                            });
                                          },
                                              showTitleActions: true,
                                              locale: LocaleType.th);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          side: BorderSide(
                                              color: Colors.grey,
                                              width: 2.0,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Text(
                                          DateFormat("HH:mm")
                                              .format(_timeChoose!),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  child: DropdownButton<String>(
                                    value: dropdownTripValue,
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownTripValue = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'เลือกทริป',
                                      'Permanent',
                                      'Temporary',
                                      'Transient'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: Text("Relay Show",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[3],
                                decoration: InputDecoration(
                                  labelText: "สฟ.",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: TextFormField(
                                controller: mEditingController[4],
                                decoration: InputDecoration(
                                  labelText: "อากาศ",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: TextFormField(
                                controller: mEditingController[5],
                                decoration: InputDecoration(
                                  labelText: "Relay",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: TextFormField(
                                controller: mEditingController[6],
                                decoration: InputDecoration(
                                  labelText: "LFL",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: TextFormField(
                                controller: mEditingController[7],
                                decoration: InputDecoration(
                                  labelText: "AFA",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: TextFormField(
                                controller: mEditingController[8],
                                decoration: InputDecoration(
                                  labelText: "LLS",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: Text("รายละเอียดการตรวจ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[9],
                                decoration: InputDecoration(
                                  labelText: "ได้รับแจ้งจาก",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                              child: Text("วันเวลาที่ตรวจ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 20.0, 0.0, 0.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          DatePicker.showDatePicker(context,
                                              currentTime: _dateChoose2,
                                              onConfirm: (time) {
                                            setState(() {
                                              _dateChoose2 = time;
                                            });
                                          },
                                              showTitleActions: true,
                                              locale: LocaleType.th)
                                        },
                                        style: OutlinedButton.styleFrom(
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          side: BorderSide(
                                              color: Colors.grey,
                                              width: 2.0,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Text(
                                          DateFormat("dd/MM/yyyy")
                                              .format(_dateChoose2!),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 20.0, 20.0, 0.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () => {
                                          DatePicker.showTimePicker(context,
                                              currentTime: _timeChoose2,
                                              onConfirm: (time) {
                                            setState(() {
                                              _timeChoose2 = time;
                                            });
                                          },
                                              showTitleActions: true,
                                              locale: LocaleType.th)
                                        },
                                        style: OutlinedButton.styleFrom(
                                          textStyle:
                                              TextStyle(color: Colors.black),
                                          side: BorderSide(
                                              color: Colors.grey,
                                              width: 2.0,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Text(
                                          DateFormat("HH:mm")
                                              .format(_timeChoose2!),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: Text("ผลการตรวจ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[10],
                                decoration: InputDecoration(
                                  labelText: "ผลการตรวจ",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
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
                                child: Container(
                                  width: double.infinity,
                                  child: DropdownButton<String>(
                                    value: dropdownFixedValue,
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownFixedValue = newValue!;
                                      });
                                    },
                                    items: <String>['ดำเนินการทันที', 'รอแก้ไข']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )),
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
                                          getImage1();
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(
                                                _selectedImageFile1, 0),
                                          ),
                                        ),
                                      ))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Material(
                                          child: InkWell(
                                        onTap: () {
                                          getImage2();
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(
                                                _selectedImageFile2, 1),
                                          ),
                                        ),
                                      ))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Material(
                                          child: InkWell(
                                        onTap: () {
                                          getImage3();
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(
                                                _selectedImageFile3, 2),
                                          ),
                                        ),
                                      ))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Material(
                                          child: InkWell(
                                        onTap: () {
                                          getImage4();
                                        },
                                        child: Container(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: prepareImage(
                                                _selectedImageFile4, 3),
                                          ),
                                        ),
                                      ))),
                                ]),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[11],
                                decoration: InputDecoration(
                                  labelText: "วิธีแก้ไข",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: Wrap(
                                spacing: 10.0,
                                children: <Widget>[
                                  for (var i = 0; i < _problem.length; i++)
                                    Chip(
                                      backgroundColor: Colors.amber,
                                      label: Text(
                                        _problem[i],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      deleteIconColor: Colors.white,
                                      onDeleted: () {
                                        setState(() {
                                          _problem.removeAt(i);
                                        });
                                      },
                                    )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: TextFormField(
                                controller: mEditingController[12],
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () {
                                      if (mEditingController[12]
                                          .text
                                          .isNotEmpty) {
                                        setState(() {
                                          _problem
                                              .add(mEditingController[12].text);
                                          mEditingController[12].text = "";
                                        });
                                      }
                                    },
                                  ),
                                  labelText: "ปัญหาสำคัญที่พบเจอ",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(),
                                  ),
                                  hintText: "กรอกข้อมูล",
                                  //fillColor: Colors.green
                                ),
                                onFieldSubmitted: (text) {
                                  if (text.isNotEmpty) {
                                    setState(() {
                                      _problem.add(text);
                                      mEditingController[11].text = "";
                                    });
                                  }
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
                          //mainAxisAlignment: MainAxisAlignment.start,
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
                          //mainAxisAlignment: MainAxisAlignment.start,
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
                              textStyle: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState!.validate()) {
                                List<Map> body = [];
                                var towerNo = this.reportDao!.towerId != ""
                                    ? this.reportDao!.towerId
                                    : MyApp.tower!.id;
                                body.add({
                                  "key": "problem",
                                  "type": "string",
                                  "value": _problem.join(",")
                                });
                                body.add({
                                  "key": "date_trip",
                                  "type": "string",
                                  "value": DateFormat("dd/MM/yyyy")
                                      .format(_dateChoose2!)
                                });
                                body.add({
                                  "key": "time_trip",
                                  "type": "string",
                                  "value":
                                      DateFormat("HH:mm").format(_dateChoose2!)
                                });
                                body.add({
                                  "key": "date_report",
                                  "type": "string",
                                  "value": DateFormat("dd/MM/yyyy")
                                      .format(_dateChoose!)
                                });
                                body.add({
                                  "key": "time_report",
                                  "type": "string",
                                  "value":
                                      DateFormat("HH:mm").format(_dateChoose!)
                                });
                                body.add({
                                  "key": "trip",
                                  "type": "string",
                                  "value": dropdownTripValue
                                });
                                body.add({
                                  "key": "result_fixed",
                                  "type": "string",
                                  "value": dropdownFixedValue
                                });
                                body.add({
                                  "key": "name",
                                  "type": "string",
                                  "value": "งานตรวจหาสาเหตุสายขัดข้อง"
                                });
                                for (var i = 0; i < topic.length - 1; i++) {
                                  body.add({
                                    "key": topic[i],
                                    "type": "string",
                                    "value": mEditingController[i].text
                                  });
                                }
                                var oj = ObjectRequestSendReport(
                                    body, "10", towerNo!, reportDao!);
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
                                                      Colors.yellow),
                                            ),
                                          ),
                                        ));
                                SendReportUseCase.serReport(oj, (response) {
                                  if (response.code! < 300) {
                                    AttachmentService.createAttachment2(
                                            _selectedImageFile1,
                                            _selectedImageFile2,
                                            _selectedImageFile3,
                                            _selectedImageFile4,
                                            response.reportId!)
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

  Widget prepareImage(_selectedImageFile, int position) {
    if (_selectedImageFile != null) {
      try {
        var url = reportDao!.images![position];
        return Image.network(url);
      } catch (e) {
        return Image.file(
          _selectedImageFile!,
          fit: BoxFit.fitHeight,
        );
      }
    } else
      return Image.asset(
        "assets/placeholder.png",
        fit: BoxFit.fitHeight,
      );
  }

  getImage1() async {
    final selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(selectedFile!.path);
    setState(() {
      _selectedImageFile1 = File(selectedFile.path);
    });
  }

  getImage2() async {
    final selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(selectedFile!.path);
    setState(() {
      _selectedImageFile2 = File(selectedFile.path);
    });
  }

  getImage3() async {
    final selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(selectedFile!.path);
    setState(() {
      _selectedImageFile3 = File(selectedFile.path);
    });
  }

  getImage4() async {
    final selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(selectedFile!.path);
    setState(() {
      _selectedImageFile4 = File(selectedFile.path);
    });
  }
}
