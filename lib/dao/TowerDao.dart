import 'package:egattracking/dao/DataTower.dart';

class TowerDao {
  List<Data>? data;
  int? limit;
  int? page;

  TowerDao({required this.data, required this.limit, required this.page});

  TowerDao.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data =  <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    limit = json['limit'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    data['page'] = this.page;
    return data;
  }
}

