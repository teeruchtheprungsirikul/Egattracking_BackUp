class UploadImagesDao {
  int code;
  String message;
  String data;

  UploadImagesDao({required this.code, required this.message, required this.data});

  factory UploadImagesDao.fromJson(Map<String, dynamic> json) => UploadImagesDao(
    code : json['code'],
    message : json['message'],
    data : json['data'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}