import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom1.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom2.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom3.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom4.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom5.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom6.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom7.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom8.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom9.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom10.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom11.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom12.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom13.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom14.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom15.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom16.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom17.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom18.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom19.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom20.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom21.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom22.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom23.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom24.dart';
import 'package:egattracking/fragment/add_report/AddReportFrom25.dart';
import 'package:egattracking/service/ReportService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';

class HistoryFragment extends StatefulWidget {

  HistoryFragment({Key? key}):super(key: key);

  @override
  _HistoryFragmentState createState() => _HistoryFragmentState();
}

class _HistoryFragmentState extends State<HistoryFragment>  {
  @override
  void initState() {
    _reports = ReportService.getReport();
    super.initState();
  }

  String getOrDefault(ReportDao reports,String  key){
    String a;
    try{
      a = reports.values.firstWhere((it) => it.key == key).value!;
    }catch( exception ){
      a = "empty";
    }
    return a;
  }

  String getWire(ReportDao reports,int index){
    String a;
    try{
      a = reports.values.firstWhere((it) => it.key == "wire_detail").value!;
      a = a.split(":")[index];
      return a;
    }catch(e){
      return "";
    }
  }
  late Future<List<ReportDao>> _reports;

  Widget renderReports(List<ReportDao> reports) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ListTile(
                        leading: InkWell(
                          child: ImageIcon(AssetImage("line.png")),
                          onTap: (){
                              // launchUrl(
                              // Uri.parse("https://line.me/R/")
                              // {LaunchMode mode = LaunchMode.platformDefault,
                              // WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
                              // String? webOnlyWindowName}
                              // );
                              launchUrl(Uri.parse("https://line.me/R/"),
                              mode: LaunchMode.platformDefault,
                  
                              );
                          },
                        ),
                        title: RichText(
                          text: TextSpan(
                            text: 'You ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 2.0),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${getOrDefault(reports[index], "name")}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                        subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                      'ชื่อสาย : ${getWire(reports[index], 0)}',
                                      style: TextStyle(height: 2.0)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                      'เลขสาย : ${getWire(reports[index], 1)}',
                                      style: TextStyle(height: 2.0)),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('yyyy/MM/dd').format(reports[index].modifiedOn)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                        height: 2.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 4.0),
                                    child: Icon(
                                      Icons.timer,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat.Hms().format(reports[index].modifiedOn)}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                        height: 2.0),
                                  ),
                                ],
                              ),
                            ]),
                        onTap: () => {
                          editReport(reports[index],context)
                      },
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  void editReport(ReportDao reportDao,BuildContext context){
    int type = int.parse("${reportDao.type}");
    switch(type){
      case 1 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm1(reportDao: reportDao)));
      break;
      case 2 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm2(reportDao: reportDao)));
      break;
      case 3 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm3(reportDao: reportDao)));
      break;
      case 4 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm4(reportDao: reportDao)));
      break;
      case 5 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm5(reportDao: reportDao)));
      break;
      case 6 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm6(reportDao: reportDao)));
      break;
      case 7 : Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm7(reportDao: reportDao)));
      break;
      case 8 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm8(reportDao: reportDao)));
      break;
      case 9 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm9(reportDao: reportDao)));
      break;
      case 10 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm10(reportDao: reportDao)));
      break;
      case 11 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm11(reportDao: reportDao)));
      break;
      case 12 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm12(reportDao: reportDao)));
      break;
      case 13 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm13(reportDao: reportDao)));
      break;
      case 14 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm14(reportDao: reportDao)));
      break;
      case 15 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm15(reportDao: reportDao)));
      break;
      case 16:  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm16(reportDao: reportDao)));
      break;
      case 17 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm17(reportDao: reportDao)));
      break;
      case 18 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm18(reportDao: reportDao)));
      break;
      case 19 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm19(reportDao: reportDao)));
      break;
      case 20 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm20(reportDao: reportDao)));
      break;
      case 21 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm21(reportDao: reportDao)));
      break;
      case 22 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm22(reportDao: reportDao)));
      break;
      case 23 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm23(reportDao: reportDao)));
      break;
      case 24 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm24(reportDao: reportDao)));
      break;
      case 25 :  Navigator.push(context, MaterialPageRoute(builder: (mContext) => AddReportForm25(reportDao: reportDao)));
      break;
    }
  }
  List<String> yearDropDownValues = <String>['2019', '2018', '2017', '2016'];
  List<String> monthDropDownValues = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<String> teamDropDownValues = <String>[
    'Team A',
    'Team B',
    'Team C',
    'Team D'
  ];
  late String yearDropDownValue;

  late String monthDropDownValue;

  late String teamDropDownValue;

  //:TODO create type filter for admin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xfff7f8fa),
              child: FutureBuilder<List<ReportDao>>(
                future: _reports,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return renderReports(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}