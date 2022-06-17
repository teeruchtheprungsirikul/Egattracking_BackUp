class ReportValueDao {
  String key;
  String type;
  String value;

  ReportValueDao({this.key, this.type, this.value});

  ReportValueDao.fromjson(Map<String,dynamic>json){
    key = json['key'];
    type = json['type'];
    value = json['value'];
  }
}