import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wajed_delivery/Models/Order.dart';
import 'package:wajed_delivery/UI/screens/OrderDetail.dart';

import 'package:wajed_delivery/shared_data.dart';

class OrderItem extends StatelessWidget {
  Order order;
  OrderItem({this.order});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pushPage(page: OrderDetail(order),context: context);
      },
      child: Container(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                 imageUrl: testImage,
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                ),
              ),
              boxw15,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title:order.username, color: Colors.black,isBold: true),
                    boxh15,
                    subTitleText(title: order.marketname, ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.black,
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
                            // subTitleText(title: twoDc(getDistanceFromLatLonInKm(order.rLat, order.rLng, order.deliveryAddress.latitude, order.deliveryAddress.longitude), 2).toString()+"  km")
                            subTitleText(title: order.market_distance.toString()+"  كم  ")
                          ],
                        )),
                        Column(
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: 30,
                            ),
                            subTitleText(title: 'العميل')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
