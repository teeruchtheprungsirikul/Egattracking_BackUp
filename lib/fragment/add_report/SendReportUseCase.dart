import 'package:egattracking/dao/PostReportDao.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:egattracking/main.dart';
import 'package:egattracking/service/ReportService.dart';

class SendReportUseCase {
  static void serReport(ObjectRequestSendReport ob, Function(PostReportDao) f) {
    if(ob.reportDao == null) {
      ReportService.sendReport(
          ob.body, ob.type, ob.towerNo).then(f);
    }else {
      ReportService.editReport(ob.body, ob.type, ob.towerNo, ob.reportDao.id).then(f);
    }
  }
}

class ObjectRequestSendReport {
  List<Map> body;
  String type;
  String towerNo;
  ReportDao reportDao;

  ObjectRequestSendReport(List<Map> body,
      String type,
      String towerNo,
      ReportDao reportDao) {
    this.body = body;
    this.type = type;
    this.towerNo = towerNo;
    this.reportDao = reportDao;
    try{
      this.body.add({
        "key": "wire_detail",
        "type": "string",
        "value": "${MyApp.tower.name}:${MyApp.tower.type}"
      });
    }catch(error){

    }

  }
}