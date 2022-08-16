class ProfileDao {
  String? createdOn;
  bool? deleted;
  String email;
  String firstname;
  String id;
  String? lastLogin;
  String lastname;
  String? modifiedOn;
  String refreshToken;
  String role;
  String team;
  String username;
  String? imageUrl;

  ProfileDao(
      {required this.createdOn,
      required this.deleted,
      required this.email,
      required this.firstname,
      required this.id,
      required this.lastLogin,
      required this.lastname,
      required this.modifiedOn,
      required this.refreshToken,
      required this.role,
      required this.team,
      required this.username,
      required this.imageUrl});

  factory ProfileDao.fromJson(Map<String, dynamic> json) => ProfileDao( 
    createdOn : json['created_on'],
    deleted : json['deleted'],
    email : json['email'],
    firstname : json['firstname'],
    id : json['id'],
    lastLogin : json['last_login'],
    lastname : json['lastname'],
    modifiedOn : json['modified_on'],
    refreshToken : json['refresh_token'],
    role : json['role'],
    team : json['team'],
    username : json['username'],
    imageUrl : json['profile_image_url'],
  
  );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['created_on'] = this.createdOn;
    data['deleted'] = this.deleted;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['id'] = this.id;
    data['last_login'] = this.lastLogin;
    data['lastname'] = this.lastname;
    data['modified_on'] = this.modifiedOn;
    data['refresh_token'] = this.refreshToken;
    data['role'] = this.role;
    data['team'] = this.team;
    data['username'] = this.username;
    data['profile_image_url'] = this.imageUrl;
    return data;
  }
}
