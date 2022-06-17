

class RefreshTokenDao {
  String accessToken;
  String tokenType;
  int expiresIn;
  String uid;

  RefreshTokenDao({this.accessToken, this.tokenType, this.expiresIn, this.uid});

  RefreshTokenDao.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['uid'] = this.uid;
    return data;
  }
}
