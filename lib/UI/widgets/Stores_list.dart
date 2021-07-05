import 'package:flutter/material.dart';
import 'package:wajed_delivery/Models/Market.dart';
import 'package:wajed_delivery/UI/widgets/image_icon.dart';
import 'package:wajed_delivery/UI/widgets/store_item.dart';
import 'package:wajed_delivery/shared_data.dart';

class StoresList extends StatelessWidget {

  List<Store> stores ;

  StoresList(this.stores);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1),
        itemCount: stores.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (ctx, i) {
          return i == 0 ? HeadItem() : StoreItem(stores[i]);
        });
  }

  HeadItem() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(50)),

              child: ImageIconView(
                size: 30,
                color: Colors.white.withOpacity(0.8),
                name: 'nearby.png',
              )),
          boxw15,
          boxw15,
          titleText(title: 'المتاجر القريبة',color:Colors.black45,fSize: 18.0),
         SizedBox(width: 80,),
          // titleText(title: 'حسب الأقرب',color: socondColor),
        ],
      ),
    );
  }
}
