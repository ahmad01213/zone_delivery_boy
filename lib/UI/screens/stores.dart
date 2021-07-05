import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/screens/search_market.dart';
import 'package:wajed_delivery/UI/widgets/Stores_list.dart';
import 'package:wajed_delivery/UI/widgets/image_icon.dart';
import 'package:wajed_delivery/UI/widgets/loading_list.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import 'package:wajed_delivery/shared_data.dart';
class Stores extends StatelessWidget {
  UserProvider _userProvider;
  initData(context) async {
    if(_userProvider == null){
      _userProvider = Provider.of(context);
      await getLocation();
      _userProvider.getNearbyStors(lat: locationData.latitude,lng: locationData.longitude,context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
      initData(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: firstColor.withOpacity(0.9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              InkWell(
                onTap: (){
                  pushPage(page: SearchMarket(),context: context);
                },
                child: Container(
                  height: 40,
                  width: 300,
                  child: TextField(
                    textAlign: TextAlign.start,
                    enabled: false,
                    style: new TextStyle(color: Colors.grey[800], fontSize: 15),

                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)),
                            borderSide: BorderSide(color: firstColor)),
                        enabledBorder: new OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(const Radius.circular(10.0)),
                          borderSide: BorderSide(color: firstColor),
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        hintStyle:
                            new TextStyle(color: Colors.grey[800], fontSize: 15),
                        hintText: "ابحث عن متجرك",
                        contentPadding: EdgeInsets.all(5),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              ImageIconView(
                  size: 30, name: 'location.png', color: Colors.white),
              SizedBox(),
            ],
          ),
        ),
        body:_userProvider.loading?Center(
          child: SpinKitRing(
            size: 60,
            color: mainColor,
            lineWidth: 7,
            duration: Duration(milliseconds: 600),
          ),
        ): StoresList(_userProvider.nearbyMarkets));
  }
}
