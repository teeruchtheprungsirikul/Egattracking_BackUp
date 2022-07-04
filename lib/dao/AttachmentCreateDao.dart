import 'package:egattracking/dao/AttachmentData.dart';

class AttachmentCreateDao {
  int code;
  String message;
  AttachmentData? data = AttachmentData(id: '', parentId: '', filename: '', extension: '', createdBy: '', createdOn: '', deleted: false, modifiedBy: '', modifiedOn: '', type: '', url: '');
  

  AttachmentCreateDao({required this.code, required this.message, required this.data});

  factory AttachmentCreateDao.fromJson(Map<String, dynamic> json) => AttachmentCreateDao(
    code : json['code'],
    message : json['message'], 
    data : json['data'] != null ? new AttachmentData.fromJson(json['data']) : null,
   
  );
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}
