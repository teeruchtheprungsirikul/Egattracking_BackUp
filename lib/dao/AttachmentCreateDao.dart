class AttachmentCreateDao {
  int code;
  String message;
  AttachmentData? data; 
    //= AttachmentData(id: '', parentId: '', filename: '', extension: '', createdBy: '', createdOn: '', deleted: false, modifiedBy: '', modifiedOn: '', type: '', url: '');
  

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


class AttachmentData {
  String id;
  String parentId;
  String filename;
  String extension;
  String type;
  String url;
  String createdBy;
  String createdOn;
  String modifiedBy;
  String modifiedOn;
  bool deleted;

  AttachmentData(
      {required this.id,
        required this.parentId,
        required this.filename,
        required this.extension,
        required this.type,
        required this.url,
        required this.createdBy,
        required this.createdOn,
        required this.modifiedBy,
        required this.modifiedOn,
        required this.deleted});

  factory AttachmentData.fromJson(Map<String, dynamic> json) => AttachmentData(
    id : json['id'],
    parentId : json['parent_id'],
    filename : json['filename'],
    extension : json['extension'],
    type : json['type'],
    url : json['url'],
    createdBy : json['created_by'],
    createdOn : json['created_on'],
    modifiedBy : json['modified_by'],
    modifiedOn : json['modified_on'],
    deleted : json['deleted'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['filename'] = this.filename;
    data['extension'] = this.extension;
    data['type'] = this.type;
    data['url'] = this.url;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['modified_by'] = this.modifiedBy;
    data['modified_on'] = this.modifiedOn;
    data['deleted'] = this.deleted;
    return data;
  }
}