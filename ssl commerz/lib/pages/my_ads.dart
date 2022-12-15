import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_approach/stripe/payment_controller.dart';

class MyAds extends StatelessWidget {
  List products = [
    {
      'product_name': 'Apple Watch',
      'image': 'assets/images/watch.png',
      'price': '\$ 88.45',
      'description': 'Series 6 Red'
    },
    {
      'product_name': 'Iphone-13',
      'image': 'assets/images/iphone-13.webp',
      'price': '\$ 1200',
      'description': 'Only white & Black colour available',
    },
  ];

  Future<void> sslCommerzGeneralCall() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'learn637a7078165de',
        store_passwd: 'learn637a7078165de@ssl',
        total_amount: 500.0,
        tran_id: '12124',
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        Fluttertoast.showToast(
          msg: "Transaction is Failed....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (result.status!.toLowerCase() == "closed") {
        Fluttertoast.showToast(
          msg: "SDK Closed by User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
            msg:
                "Transaction is ${result.status} and Amount is ${result.amount}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  PaymentController _paymentController = PaymentController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Ads',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            indicatorColor: Colors.grey,
            labelColor: Colors.black,
            indicatorWeight: 3,
            tabs: [
              Tab(
                //text: 'My Cart',
                child: Column(
                  children: [
                    Icon(Icons.shopping_bag_outlined),
                    SizedBox(
                      height: 2,
                    ),
                    Text('My Cart')
                  ],
                ),
              ),
              Tab(
                //text: 'My Cart',
                child: Column(
                  children: [
                    Icon(Icons.favorite_outline),
                    SizedBox(
                      height: 2,
                    ),
                    Text('My Favourite')
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          products[index]['image'],
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Text(
                                        products[index]['product_name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        products[index]['description'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        products[index]['price'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF5956E9),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () => _paymentController.makePayment(
                          amount: '1000',
                          currency: 'USD',
                        ),
                        child: Text('continue to pay \$1000'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  top: 20,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                products[index]['image'],
                              ),
                            ),
                            title: Text(
                              products[index]['product_name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              products[index]['description'],
                              style: TextStyle(),
                            ),
                            trailing: Text(
                              products[index]['price'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF5956E9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: ()=>sslCommerzGeneralCall(),
                        child: Text('Pay Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
