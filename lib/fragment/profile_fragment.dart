import 'dart:io';

import 'package:egattracking/dao/ProfileDao.dart';
import 'package:egattracking/fragment/edit_profile_fragment.dart';
import 'package:egattracking/service/UserService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:ui';



class ProfileFragment extends StatefulWidget {
  final ValueChanged<bool> logoutTriggeredAction;

  const ProfileFragment({Key? key, required this.logoutTriggeredAction})
      : super(key: key);

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  late Future<ProfileDao> _profile;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context ) => Container(
            width: 40,
            height: 40,
            child: Center(
              child: Loading(
                indicator: BallSpinFadeLoaderIndicator(),
                size: 40.0,
                color: Colors.yellow,
              ),
            ),
          )
      );
      UserService.uploadImage(image).then((response){
        setState(() {
          _image = image;
          Navigator.pop(context,true);
        });
      });
    }else{
      Navigator.pop(context,true);
    }

  }

  @override
  void initState() {
    _profile = UserService.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.white,
          ),
      body: FutureBuilder<ProfileDao>(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return renderProfile(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(0.0),
        child: FlatButton(
          onPressed: () {
            UserService.logout();
            widget.logoutTriggeredAction(true);
            Navigator.pop(context);
          },
          color: Colors.white,
          textColor: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.exit_to_app),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderProfile(ProfileDao profile) {
    return Container(
      child: Center(
          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              Container(
                width: 190.0,
                height: 190.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: setImage(profile.imageUrl),
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        shape: BoxShape.circle
                    )
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                    icon: Icon(Icons.camera_alt,color: Colors.grey,),
                  onPressed: getImage,
                  color:  Colors.amberAccent,
                ),
              )
            ],
          ),
        ),
        Text("${profile.firstname} ${profile.lastname}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black)),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(profile.email,
                style: TextStyle(fontSize: 14, color: Colors.grey))),
        Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.work, color: Colors.grey),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(profile.role)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.perm_identity, color: Colors.grey),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(profile.id)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.business, color: Colors.grey),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(profile.team)),
                  ],
                ),
              )
            ],
          ),
        )
      ])),
    );
  }

  Widget setImage (String image) {
    if(_image==null) {
      if(image == null || image.isEmpty){
        return Image.asset("people.png");
      }
      return Image.network(
      image,
      fit: BoxFit.fitHeight,
      height: 190.0,
      width: 190.0,
    );}else
      return Image.file(
        _image,
        fit: BoxFit.fitHeight,
        height: 190.0,
        width: 190.0,
      );
  }
}
