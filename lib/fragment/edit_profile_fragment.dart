import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileFragment extends StatefulWidget {
  EditProfileFragment({Key? key}) :super(key: key);

  @override
  _EditProfileFragmentState createState() => _EditProfileFragmentState();
}

class _EditProfileFragmentState extends State<EditProfileFragment> {
  late File? _image;

  getImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(imageFile!.path);

    setState(() {
      _image = File(imageFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                        onPressed: getImage),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget setImage() {
    if (_image != null) {
      return Image.network(
        "https://ibb.co/v1wP2x5",
        fit: BoxFit.fitHeight,
        height: 190.0,
        width: 190.0,
      );
    } else
        return Image.file(
          _image!,
          fit: BoxFit.fitHeight,
          height: 190.0,
          width: 190.0,
        );
  }
}
