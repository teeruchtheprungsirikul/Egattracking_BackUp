class ReportValueDao {
  String? key;
  String? type;
  String? value;

  ReportValueDao({required this.key, required this.type, required this.value});

  ReportValueDao.fromjson(Map<String,dynamic>json){
    key = json['key'];
    type = json['type'];
    value = json['value'];
  }
}