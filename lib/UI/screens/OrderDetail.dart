import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wajed_delivery/Models/Order.dart';
import 'package:wajed_delivery/Models/OrderFood.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/widgets/Buttons.dart';
import 'package:wajed_delivery/UI/widgets/SizedBoxWidget.dart';
import 'package:wajed_delivery/UI/widgets/Texts.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import 'package:wajed_delivery/shared_data.dart';
class OrderDetail extends StatelessWidget {
  Order order;
  OrderDetail(this.order);
  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      _userProvider.orderDetail=null;
      _userProvider.getOrderDetail(orderId: order.id,context: context,);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        title: Texts(
          fSize: 16,
          title: "طلب رقم  :  " + order.id.toString(),
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:_userProvider.startLoading?Center(
        child: SpinKitRing(
          size: 60,
          color: mainColor,
          lineWidth: 7,
          duration: Duration(milliseconds: 600),
        ),
      ): Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                child: titleText(
                    title: "الخريطة", color: socondColor, isBold: true),
                padding: EdgeInsets.all(20)),
            Box(10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        launchMapsUrl(locationData.latitude, locationData.longitude, _userProvider.orderDetail.order.market_lat, _userProvider.orderDetail.order.market_lng);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Texts(
                              title: "موقع المتجر",
                              fSize: 15,
                              weight: FontWeight.bold,
                              lines: 2,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                         launchMapsUrl(locationData.latitude, locationData.longitude, _userProvider.orderDetail.order.user_lat, _userProvider.orderDetail.order.user_lng);

                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Texts(
                              title: "موقع العميل",
                              fSize: 15,
                              lines: 2,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Box(30),
            Container(height: 5,color: Colors.grey.withOpacity(0.6),),


            Row(children: [
              Padding(
                  child: titleText(
                      title: "اسم العميل", color: Colors.black, isBold: true),
                  padding: EdgeInsets.all(20)),
              Padding(
                  child: titleText(
                      title:_userProvider.orderDetail.order.username , color: socondColor, isBold: true),
                  padding: EdgeInsets.all(20)),
            ],),
            Box(10),
            Padding(
                child: titleText(
                    title: "حالة الطلب", color: socondColor, isBold: true),
                padding: EdgeInsets.all(20)),
            Box(10),
            buildStepperView(status: _userProvider.orderDetail.order.status),
            Box(30),
            Container(height: 5,color: Colors.grey.withOpacity(0.6),),
            Box(10),

            Padding(
                child: titleText(
                    title: "تفاصيل الطلب", color: socondColor, isBold: true),
                padding: EdgeInsets.all(20)),
            Box(10),
            buildOrderItemsList()
          ],
        ),
      ),
    );
  }
  static void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }
  buildStepperView({int status}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Colors.green,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 1 ? Colors.black : Colors.grey,
              )),
              Icon(
                Icons.store,
                color: status > 1 ? Colors.green : Colors.grey,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 2 ? Colors.black : Colors.grey,
              )),
              Icon(
                Icons.delivery_dining,
                color: status > 2 ? Colors.green : Colors.grey,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 3 ? Colors.black : Colors.grey,
              )),
              Icon(
                Icons.account_circle,
                color: status > 3 ? Colors.green : Colors.grey,
                size: 40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 60,
                  child: Texts(
                    title: "جاري البحث عن مندوب",
                    fSize: 13,
                    align: TextAlign.center,
                    color: Colors.black,
                    lines: 3,
                  )),
              Container(
                  width: 60,
                  child: Texts(
                    title: "في انتظار المندوب",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 1 ? Colors.black : Colors.grey,
                    lines: 3,
                  )),
              Container(
                  width: 80,
                  child: Texts(
                    title: "جاري التوصيل للعميل",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 2 ? Colors.black : Colors.grey,
                    lines: 2,
                  )),
              Container(
                  width: 60,
                  child: Texts(
                    title: "تم التسليم للعميل",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 3 ? Colors.black : Colors.grey,
                    lines: 3,
                  ))
            ],
          ),
          Box(25),
          if(_userProvider.orderDetail.order.status<=4)  Container(
            height: 40,
            child: Buttons(
              title: checkStatus(status: status),
              radius: 10,
              horizontalMargin: 30,
              textColol: Colors.white,
              bgColor: Colors.black,
              onPressed: () {
                _userProvider.updatOrderStatus(status+1);
              },
            ),
          ),
        ],
      ),
    );
  }

  buildOrderItemsList(){
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
        itemCount: _userProvider.orderDetail.foods.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx,i){
          OrderFood orderFood = _userProvider.orderDetail.foods[i];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: testImage,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              boxw15,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      titleText(title:orderFood.food.name ),
                      SizedBox(width: 30,),
                      titleText(title:"السعر  :  ${orderFood.food.price.toString()} ريال",color: Colors.green ),

                    ],
                  ),
                  boxh15,
                  subTitleText(title: "الكمية  :  ${orderFood.quantity.toString()}"),

                ],
              )
            ],
          ),
        );
    });
  }

  List statusStrings = [
    "قبول الطلب",
    "في انتظار المندوب",
    "تم استلام الطلب من المتجر",
    "تم التسليم للعميل"
  ];
  checkStatus({int status, onPress}) {
    return statusStrings[status -1];
  }
}
