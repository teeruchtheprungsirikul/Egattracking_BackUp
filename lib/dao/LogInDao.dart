class LoginDao {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;
  String? uid;
  String? role;

  LoginDao(
      {
        this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.refreshToken,
        this.uid,
        this.role
        
      }
  );

  factory LoginDao.fromJson(Map<String, dynamic> json) => LoginDao(
    accessToken : json['access_token'],
    tokenType : json['token_type'],
    expiresIn : json['expires_in'],
    refreshToken : json['refresh_token'],
    uid : json['uid'],
    role : json['role'],
  );
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['uid'] = this.uid;
    data['role'] = this.role;
    return data;
  }
}
