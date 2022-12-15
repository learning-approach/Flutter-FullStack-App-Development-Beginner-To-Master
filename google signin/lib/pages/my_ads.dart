
import 'package:flutter/material.dart';

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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 25,
                  left: 25,
                  top: 20,
                ),
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
            ),
          ],
        ),
      ),
    );
  }
}
