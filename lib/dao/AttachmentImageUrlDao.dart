class AttachmentImageUrlDao {
  String parentId;
  String url;

  AttachmentImageUrlDao({this.parentId, this.url});

  AttachmentImageUrlDao.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['url'] = this.url;
    return data;
  }
}
