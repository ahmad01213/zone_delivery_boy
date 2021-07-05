import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/screens/SignIn.dart';
import 'package:wajed_delivery/UI/widgets/RatingBar.dart';
import 'package:wajed_delivery/UI/widgets/SizedBoxWidget.dart';
import 'package:wajed_delivery/UI/widgets/image_icon.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import '../../shared_data.dart';
class Account extends StatelessWidget {
  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      // _userProvider.getProfile(context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // pushPage(page: Settings(), context: context);
                  },
                  child: Box(5),
                  // child: ImageIconView(
                  //   color: Colors.white,
                  //   size: 30,
                  //   name: 'settings.png',
                  // ),
                ),
                titleText(title: 'حسابي', color: Colors.white, fSize: 20.0),
                IconButton(onPressed: (){
                  signOut(ctx: context,page: SignInScreen());
                }, icon: Icon(
                  Icons.power_settings_new,
                  size: 30,
                ))
              ],
            )
          ],
        ),
      ),
      body:_userProvider.startLoading||_userProvider.driver==null?Center(
      ): Column(
        children: [
          Container(
            color: firstColor,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    testImage,
                    height: 100,
                    width: 100,
                    fit:BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(
                        title: _userProvider.driver.name, color: Colors.white),
                    RatingBarWidget(
                      ratingValue: _userProvider.driver.rate.toDouble() ,
                      itemSize: 30,
                      ignorGesture: true,
                      fillColor: Colors.yellow,
                      emptColor: Colors.white,
                    ),
                    subTitleText(title: 'الحساب موثق', color: Colors.white),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          rowItem(key: 'رصيد الحساب', value: _userProvider.driver.balance.toString(), isFirst: true),
          // rowItem(key: 'إجمالي رسوم التوصيل', value: "120  ريال"),
          // rowItem(key: 'إجمالي الفواتير المدفوعة', value: "120"),
          rowItem(key: 'عدد الطلبات', value: _userProvider.driver.orderCount.toString()),
          rowItem(key: 'مراجعات المستخدمين', value: _userProvider.driver.reviews.toString()),
        ],
      ),
    );
  }

  rowItem({key, value, isFirst = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black45,
            ),
            top: isFirst
                ? BorderSide(
                    width: 0.5,
                    color: Colors.black45,
                  )
                : BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText(fSize: 16.0, color: Colors.black54, title: key),
          titleText(fSize: 17.0, title: value, color: firstColor)
        ],
      ),
    );
  }
}
