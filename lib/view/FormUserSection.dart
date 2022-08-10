import 'package:egattracking/models/section.dart';
import 'package:flutter/material.dart';



class FromUserSection extends StatefulWidget {
  FromUserSection(String firstname, String team, String imageUrl);

  @override
  State<FromUserSection> createState() => _FromUserSectionState();
}

class _FromUserSectionState extends State<FromUserSection> {
 Section _section = Section(department: '', imageRef: '', name: '');

  ImageProvider setupImage() {
    if (_section.imageRef.isEmpty) {
      return AssetImage("people.png");
    } else
      return NetworkImage(_section.imageRef);
  }

  

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(fit: BoxFit.cover, image: setupImage())),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
              child: Text("ผู้บันทึก",
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1, color: Colors.black38)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
              child: Text(_section.name ,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.2, color: Colors.black)),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("building.png"),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
              child: Text("สังกัดหน่วย",
                  style: TextStyle(fontSize: 14, color: Colors.black38)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
              child: Text(_section.department,
                  style: TextStyle(fontSize: 14, color: Colors.black38)),
            )
          ],
        ),
      ],
    );
  }
}




