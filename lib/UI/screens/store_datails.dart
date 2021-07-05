import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wajed_delivery/Models/Market.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/widgets/SizedBoxWidget.dart';
import 'package:wajed_delivery/UI/widgets/Texts.dart';
import 'package:wajed_delivery/UI/widgets/order_item.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import '../../shared_data.dart';
class StoreDetails extends StatelessWidget {
  Store market;

  StoreDetails(this.market);

  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      _userProvider.marketDetail=null;
      _userProvider.getMarketDetail(marketId: market.id,context: context,);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: titleText(fSize: 17.0, color: Colors.white, title: market.title),
        centerTitle: true,
        backgroundColor: firstColor,
      ),
      body: _userProvider.startLoading?Center(
        child: SpinKitRing(
          size: 60,
          color: mainColor,
          lineWidth: 7,
          duration: Duration(milliseconds: 600),
        ),
      ):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
                child: titleText(title: 'معلومات المتجر ',color: socondColor,isBold: true),
                padding: EdgeInsets.all(20)
            ),
            Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.1),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boxh15,
                  titleText(title:_userProvider.marketDetail.market.title , color: Colors.black),
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.store,
                            color: Colors.black45,
                            size: 30,
                          ),
                          subTitleText(title: 'المتجر')
                        ],
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 0.5,
                                color: Colors.grey,
                                margin: EdgeInsets.symmetric(horizontal: 5),
                              ),
                              subTitleText(title:_userProvider.marketDetail.storeDistance.toString()+" كم " )
                            ],
                          )),
                      Column(
                        children: [
                          Icon(
                            Icons.delivery_dining,
                            color: Colors.black45,
                            size: 30,
                          ),
                          subTitleText(title: 'موقعك')
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            boxh15,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (){
                  launchMapsUrl(locationData.latitude, locationData.longitude, market.lat, market.lng);
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
                        title: "موقع المتجر علي الخريطة",
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
            Padding(
                child: titleText(title: 'طلبات في الإنتظار',color: socondColor,isBold: true),
                padding: EdgeInsets.all(20)
            )
            ,
            boxh15,
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _userProvider.marketDetail.orders.length,
                itemBuilder: (ctx,i){
                  return OrderItem(order:_userProvider.marketDetail.orders[i]);
                })
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
}
