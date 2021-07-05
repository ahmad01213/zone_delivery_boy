import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/widgets/image_icon.dart';
import 'package:wajed_delivery/UI/widgets/store_item.dart';
import '../../shared_data.dart';
class SearchMarket extends StatefulWidget {
  @override
  _SearchMarketState createState() => _SearchMarketState();
}
class _SearchMarketState extends State<SearchMarket> {
  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: firstColor.withOpacity(0.9),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              Container(
                height: 60,
                width: 300,
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: Form(
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      style:
                          new TextStyle(color: Colors.grey[800], fontSize: 15),
                      onFieldSubmitted: (v) async {
                        _userProvider.searchMarket(
                            text: v.toString(), context: context);


                      },
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0)),
                              borderSide: BorderSide(color: firstColor)),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0)),
                            borderSide: BorderSide(color: firstColor),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintStyle: new TextStyle(
                              color: Colors.grey[800], fontSize: 15),
                          hintText: "ابحث عن متجرك",
                          contentPadding: EdgeInsets.all(5),
                          fillColor: Colors.white70),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child:ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 1),
            itemCount: _userProvider.searchMarkets.length+1,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, i) {
              return i == 0 ? HeadItem() : StoreItem(_userProvider.searchMarkets[i-1]);
            })
      ),
    );
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
          titleText(title: 'حسب الأقرب',color: socondColor),
        ],
      ),
    );
  }

}
