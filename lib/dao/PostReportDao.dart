


class PostReportDao {
   int? code;
   String? message;
   String? reportId;

  PostReportDao({required this.code, required this.message});

  PostReportDao.fromJson(Map<String, dynamic> json) {
    try{
      code = json['code'];
      message = json['message'];
      reportId = json['data']['id'];
    }catch(error){
      if(code == null)
        code = 0;
      if(message == null)
        message = "";
      if(reportId == null)
        reportId = "";
    }
  }
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data']['id'] = this.reportId;
    return data;
  }
}