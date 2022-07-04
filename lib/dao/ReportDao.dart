import 'package:egattracking/dao/ReportValueDao.dart';
class ReportDao {
  late DateTime createdOn;
  late DateTime modifiedOn;
  late String id;
  late String towerId;
  late String type;
  late List<ReportValueDao> values;
  late List<String> images;

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
