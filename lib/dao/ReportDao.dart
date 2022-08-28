import 'package:egattracking/dao/ReportValueDao.dart';

class ReportDao {
  DateTime? createdOn;
  DateTime? modifiedOn;
  String? id;
  String? towerId;
  String? type;
  List<ReportValueDao>? values;
  List<String>? images;

  ReportDao({required this.id, required this.towerId, required this.type});

  ReportDao.fromJson(Map<String, dynamic> json) {
    createdOn = DateTime.parse(json['created_on']).toLocal();
    modifiedOn = DateTime.parse(json['modified_on']).toLocal();
    id = json['id'];
    towerId = json['tower_id'];
    type = json['type'];
    var valuesJson = json['values'] as List;
    values = valuesJson
        .map((valueJson) => ReportValueDao.fromjson(valueJson))
        .toList();
  }
}