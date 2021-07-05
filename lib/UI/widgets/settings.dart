import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wajed_delivery/shared_data.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  bool value = true;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: titleText(fSize: 17.0,color: Colors.white,title: "الإعدادات"),
        centerTitle: true,
        backgroundColor: firstColor,
      ) ,
      body: Column(children: [
        SizedBox(height: 40,),
       buildSwitch(),
        rowItem(key: 'متاجر قمت بالتسجيل بها'),
        rowItem(key: 'تعديل البروفايل'),
        rowItem(key: 'إعدادات اللغة'),
        rowItem(key: 'شروط الإستخدام'),
        rowItem(key: 'قيم التطبيق'),
      ],) ,
    );
  }

  buildSwitch(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black45,
            ),
            top: BorderSide(
              width: 0.5,
              color: Colors.black45,
            )

          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText(fSize: 16.0, color: Colors.black54, title: 'تنبيهات الطلبات القريبة'),
          CupertinoSwitch(
            activeColor: firstColor,
            value: value,
            onChanged: (v) => setState(() => value = v),
          ),
        ],
      ),
    );
  }
  rowItem({key,isFirst = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black45,
            ),
            top: isFirst?BorderSide(
              width: 0.5,
              color: Colors.black45,
            ):BorderSide(
              width: 0,
              color: Colors.transparent,
            ),

          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText(fSize: 16.0, color: Colors.black54, title: key),
          Icon(Icons.arrow_forward_ios,size: 20,color: Colors.black45,)
        ],
      ),
    );
  }
}
