

class RefreshTokenDao {
  String accessToken;
  String tokenType;
  int expiresIn;
  String uid;

  RefreshTokenDao({required this.accessToken, required this.tokenType, required this.expiresIn, required this.uid});

  factory RefreshTokenDao.fromJson(Map<String, dynamic> json) => RefreshTokenDao(
    accessToken : json['access_token'],
    tokenType : json['token_type'],
    expiresIn : json['expires_in'],
    uid : json['uid'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['uid'] = this.uid;
    return data;
  }
}
