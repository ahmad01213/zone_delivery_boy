import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wajed_delivery/Models/Market.dart';
import 'package:wajed_delivery/UI/screens/store_datails.dart';
import 'package:wajed_delivery/shared_data.dart';
class StoreItem extends StatelessWidget {
  Store market ;
   StoreItem(this.market);
   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushPage(context: context, page: StoreDetails(market));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CachedNetworkImage(
            imageUrl: filesUrl+ market.image,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            boxw15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText(title:market.title ),
                boxh15,
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: socondColor,
                      size: 25,
                    ),
                    boxw15,
                    subTitleText(title: market.distance.toString()+"  كم  "),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
