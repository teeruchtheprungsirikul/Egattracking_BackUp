class AttachmentImageUrlDao {
  String parentId;
  String url;

  AttachmentImageUrlDao({required this.parentId, required this.url});

  factory AttachmentImageUrlDao.fromJson(Map<String, dynamic> json) => AttachmentImageUrlDao( 
    parentId : json['parent_id'],
    url : json['url'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_id'] = this.parentId;
    data['url'] = this.url;
    return data;
  }
}
