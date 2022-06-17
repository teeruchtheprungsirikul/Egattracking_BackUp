import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class EditProfileFragment extends StatefulWidget {
  @override
  _EditProfileFragmentState createState() => _EditProfileFragmentState();
}

class _EditProfileFragmentState extends State<EditProfileFragment> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: Colors.white,
        ),
        body: Container(
            height: 250,
            child: Stack(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Container(
                        width: 190.0,
                        height: 190.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(190.0),
                            child: setImage(),
                    ),
                  )
                ]))),
    Padding(
    padding: const EdgeInsets.fromLTRB(0, 200, 10, 0),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
    IconButton(
    icon: Icon(
    Icons.camera_alt,
    color: Colors.black,
    ),
    onPressed: getImage ),
    ],
    ),
    )
    ],
    )
    ,
    )
    );
  }
  Widget setImage () {
    if(_image==null) { return Image.network(
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg",
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
