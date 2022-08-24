// class Data {
//   String createdOn;
//   bool deleted;
//   String id;
//   double latitude;
//   double longitude;
//   String modifiedOn;
//   String name;
//   String remark;
//   String type;

//   Data(
//         {
//         required this.createdOn,
//         required this.deleted,
//         required this.id,
//         required this.latitude,
//         required this.longitude,
//         required this.modifiedOn,
//         required this.name,
//         required this.remark,
//         required this.type
//         }
//       );

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     createdOn : json['created_on'],
//     deleted : json['deleted'],
//     id : json['id'],
//     latitude : json['latitude'],
//     longitude : json['longitude'],
//     modifiedOn : json['modified_on'],
//     name : json['name'],
//     remark : json['remark'],
//     type :'T: ' + json['type'],
//   );
   
  

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['created_on'] = this.createdOn;
//     data['deleted'] = this.deleted;
//     data['id'] = this.id;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['modified_on'] = this.modifiedOn;
//     data['name'] = this.name;
//     data['remark'] = this.remark;
//     data['type'] = this.type;
//     return data;
//   }
// }