import 'package:egattracking/Topic.dart';
import 'package:egattracking/dao/ReportDao.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class FormDifficultySection extends StatelessWidget {
  ReportDao? reportDao;
  
  FormDifficultySection(ReportDao mReportDao) {
    reportDao = mReportDao;
  }

  List<String> labelAndHintTree = [
    "ป่าไม้สูง",
    "ต้นไม้สูง",
    "หญ้าสูง",
    "กอไผ่สูง",
    "ไร่อ้อย",
    "ต้นไม้บนจอมปลวก",
    "โคนเสารก",
    "เถาวัลย์โคนเสา",
    "ต้นไม้อันตราย",
    "กอไผ่อันตราย"
  ];
  List<String> labelCheckboxWarning = [
    "อาคาร สิ่งปลูกสร้าง ต้นไม้",
    "ขุดบ่อใกล้โคนเสา",
    "ถนนใกล้โคนเสา",
    "ควรปักป้ายห้ามรุกล้ำ",
    "ป้ายประกาศชำรุดลบเลือน",
    "หลักเขตชำรุด สูญหาย"
  ];
  List<String> labelCheckboxUrgent = ["เร่งด่วน"];
  List<String> poleCheck = [
    "โคนเสา (ดินถม, น้ำเซาะ, คอนกรีดแตกร้าว)",
    "เหล็กประกอบเสา (หาย, เป็นสนิม, บิดงอ, สีโคนเสาหลุดลอก, หลายเลขเสาลบเลือน, ป้ายลบเลือน)",
    "Bolt & Nut (ขา Stub หาย, ยึด Ground หาย, ยึด Member หาย)",
    "ระบบ Ground (ขาด, เป็นสนิม)"
  ];
  List<String> wireCheck = [
    "สายไฟ (เชือก ตัว หรือหางว่าว, Strand ขาด/มีรอย Arc, Vibration Damper หลุดเลื่อน)",
    " OHG, OPGW (เชือก ตัว หรือหางว่าว, Strand ขาด/มีรอย Arc, Vibration Damper หลุดเลื่อน)"
  ];
  List<String> insulator = [
    "Flash",
    "แตกบิ่น"
  ];
  List<String> lineCrossCheck = [
    "ถนน",
    "สายส่ง 22 kV",
    "สายส่ง 115 kV",
    "สายส่ง 230 kV",
    "สายเคเบิลสื่อสาร"
  ];
  List<String> hardware = [
    "วงจร 1 (ลูกถ้วยเฟส A B C, SUSP. CLAMP, COMP. SLEEVE, ARMOR ROD, DAMPER)",
    "วงจร 2 (ลูกถ้วยเฟส A B C, SUSP. CLAMP, COMP. SLEEVE, ARMOR ROD, DAMPER)"
  ];
  late List<TextEditingController> mController;
  late List<TextEditingController> mControllerCrossCheck;
  List<bool> checkBoxValue = List.generate(6, (index) {
    return false;
  });
  List<bool> checkBoxUrgentValue = List.generate(1, (index) {
    return false;
  });
  bool isUseCrossCheck = false;

  @override
  Widget build(BuildContext context) {
    mController = List.generate(
        labelAndHintTree.length +
            poleCheck.length +
            wireCheck.length +
            insulator.length +
            lineCrossCheck.length, (index) {
      if (index < labelAndHintTree.length) {
        return TextEditingController(
            text: initialText(Topic.difficultyTree[index]));
      } else if (index < poleCheck.length + labelAndHintTree.length) {
        return TextEditingController(
            text: initialText(
                Topic.poleCheckDamage[index - labelAndHintTree.length]));
      } else if (index <
          wireCheck.length + labelAndHintTree.length + poleCheck.length) {
        return TextEditingController(
            text: initialText(Topic.wireCheckDamage[
                index - (labelAndHintTree.length + poleCheck.length)]));
      } else if (index <
          insulator.length +
              labelAndHintTree.length +
              poleCheck.length +
              wireCheck.length) {
        return TextEditingController(
            text: initialText(Topic.insulatorCheck[index -
                (labelAndHintTree.length +
                    poleCheck.length +
                    wireCheck.length)]));
      } else {
        return TextEditingController(
            text: initialText(Topic.lineCrossCheck[index -
                (labelAndHintTree.length +
                    poleCheck.length +
                    wireCheck.length +
                    insulator.length )]));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        provideTitle("ต้นไม้"),
        for (var i = 0; i < labelAndHintTree.length; i++)
          provideViewTree(i, labelAndHintTree[i], labelAndHintTree[i], 0),
        provideTitle("ตรวจสอบเสา"),
        for (var i = 0; i < poleCheck.length; i++)
          provideViewPoleCheck(
              i, poleCheck[i], poleCheck[i], labelAndHintTree.length),
        provideTitle("ตรวจสอบสาย"),
        for (var i = 0; i < wireCheck.length; i++)
          provideViewPoleCheck(i, wireCheck[i], wireCheck[i],
              labelAndHintTree.length + poleCheck.length),
        provideTitle("ตรวจสอบลูกถ้วย"),
        for (var i = 0; i < insulator.length; i++)
          provideViewInsulatorCheck(i, insulator[i], insulator[i],
              labelAndHintTree.length + poleCheck.length + wireCheck.length),
        provideTitle("ตรวจสอบ Line Crossing"),
        for (var i = 0; i < lineCrossCheck.length; i++)
          provideViewInsulatorCheck(
              i,
              lineCrossCheck[i],
              lineCrossCheck[i],
              labelAndHintTree.length +
                  poleCheck.length +
                  wireCheck.length +
                  insulator.length)
      ],
    );
  }

  Widget crossCheckSection() {
    isUseCrossCheck = true;
    mControllerCrossCheck = List.generate(hardware.length, (index) {
      return TextEditingController(
          text: initialText(Topic.hardwareCheck[index]));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        provideTitle("Hardware"),
        for (var i = 0; i < hardware.length; i++)
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: TextFormField(
              maxLines: 5,
              controller: mControllerCrossCheck[i],
              decoration: InputDecoration(
                labelText: hardware[i],
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(),
                ),
                hintText: hardware[i],
                //fillColor: Colors.green
              ),
            ),
          )
      ],
    );
  }

  Padding provideViewTree(
      int index, String label, String hint, int startIndex) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: TextFormField(
        controller: mController[startIndex + index],
        maxLines: 1,
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
          hintText: hint,
          //fillColor: Colors.green
        ),
      ),
    );
  }

  Padding provideViewPoleCheck(
      int index, String label, String hint, int startIndex) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: TextFormField(
        maxLines: 5,
        controller: mController[startIndex + index],
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
          hintText: hint,
          //fillColor: Colors.green
        ),
      ),
    );
  }

  Padding provideViewInsulatorCheck(
      int index, String label, String hint, int startIndex) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: TextFormField(
        maxLines: 1,
        controller: mController[startIndex + index],
        decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(),
          ),
          hintText: hint,
          //fillColor: Colors.green
        ),
      ),
    );
  }

  Padding provideTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<Map> getValueForPost() {
    List<Map> result = [];
    int index = 0;
    for (var i = 0; i < Topic.warningBreak.length; i++) {
      result.add({
        "key": Topic.warningBreak[i],
        "type": "string",
        "value": checkBoxValue[i].toString()
      });
    }
    for (var key in Topic.difficultyTree) {
      result.add(
          {"key": key, "type": "string", "value": mController[index++].text});
    }
    for (var key in Topic.poleCheckDamage) {
      result.add(
          {"key": key, "type": "string", "value": mController[index++].text});
    }
    for (var key in Topic.wireCheckDamage) {
      result.add(
          {"key": key, "type": "string", "value": mController[index++].text});
    }
    for (var key in Topic.insulatorCheck) {
      result.add(
          {"key": key, "type": "string", "value": mController[index++].text});
    }
    for (var key in Topic.lineCrossCheck) {
      result.add(
          {"key": key, "type": "string", "value": mController[index++].text});
    }
    if (isUseCrossCheck) {
      index = 0;
      for (var key in Topic.hardwareCheck) {
        result.add({
          "key": key,
          "type": "string",
          "value": mControllerCrossCheck[index++].text
        });
      }
    }
    return result;
  }

  String? initialText(String key) {
    if (reportDao == null)
      return "";
    else {
      try {
        return reportDao!.values.firstWhere((it) => it.key == key).value;
      } catch (error) {
        return "";
      }
    }
  }
}