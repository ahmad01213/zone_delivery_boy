import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wajed_delivery/Providers/UserProvider.dart';
import 'package:wajed_delivery/UI/screens/OrderDetail.dart';
import 'package:wajed_delivery/UI/widgets/RatingBar.dart';
import 'package:wajed_delivery/UI/widgets/SizedBoxWidget.dart';
import 'package:wajed_delivery/UI/widgets/Texts.dart';
import 'package:wajed_delivery/UI/widgets/order_item.dart';
import 'package:wajed_delivery/helpers/helpers.dart';
import 'package:wajed_delivery/shared_data.dart';

class Orders extends StatelessWidget {

  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      _userProvider.getCurrentOrders(context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
     initData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: titleText(fSize: 17.0, color: Colors.white, title: "الطلبات"),
        centerTitle: true,
        backgroundColor: firstColor,
      ),
      body:_userProvider.startLoading?Center(
        child: SpinKitRing(
          size: 25,
          color: mainColor,
          lineWidth: 5,
          duration: Duration(milliseconds: 700),
        ),
      ): Container(
        color: Colors.grey.withOpacity(0.1),
        child: ListView.builder(
            itemCount: _userProvider.currentOrders.length,
            padding: EdgeInsets.only(top: 30),
            itemBuilder: (ctx, i) {
              return InkWell(
                onTap: (){
                  pushPage(context: context,page: OrderDetail(_userProvider.currentOrders[i]));
                },
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Texts(
                                title: checkStatus(_userProvider.currentOrders[i].status-1),
                                fSize: 17,
                                color: Colors.black,
                              ),
                              Texts(
                                title: _userProvider.currentOrders[i].date,
                                fSize: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Box(5),
                          Divider(),
                          Box(5),
                          Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: Image.network(
                                    _userProvider.currentOrders[i].marketimage ,
                                    height: 50,
                                    width: 50,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts(
                                    title: _userProvider.currentOrders[i].marketname,
                                    fSize: 14,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      RatingBarWidget(
                                        ratingValue: _userProvider.currentOrders[i].rate.toDouble(),
                                        emptColor: Colors.grey,
                                        ignorGesture: true,
                                        itemSize: 15,
                                        direction: TextDirection.rtl,
                                        fillColor: Colors.orangeAccent,
                                      ),
                                      Texts(
                                        title:"  "+ _userProvider.currentOrders[i].rate.toString()+" ",
                                        fSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Box(5),
                          Divider(),
                          Box(5),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }


  List statuses = [
    "قبول الطلب",
    "في انتظار المندوب",
    "تم استلام الطلب من المتجر",
    "تم التسليم للعميل"
  ];
  checkStatus(int status){
    print(status);
    return statuses[status==0?status:status-1];
  }
}
