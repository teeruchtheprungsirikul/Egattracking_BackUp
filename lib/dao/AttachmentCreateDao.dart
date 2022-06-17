class AttachmentCreateDao {
  int code;
  String message;
  AttachmentData data;

  AttachmentCreateDao({this.code, this.message, this.data});

  AttachmentCreateDao.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new AttachmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
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
      {this.id,
        this.parentId,
        this.filename,
        this.extension,
        this.type,
        this.url,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.deleted});

  AttachmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    filename = json['filename'];
    extension = json['extension'];
    type = json['type'];
    url = json['url'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    modifiedBy = json['modified_by'];
    modifiedOn = json['modified_on'];
    deleted = json['deleted'];
  }

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