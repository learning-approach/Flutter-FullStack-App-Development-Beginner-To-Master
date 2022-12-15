import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  
  List<String> categories = [
    'Food',
    'Electronics',
    'Groceries',
    'Clothes',
    'Cosmetics',
    'SmartPhone',
    'Laptop'
  ];

  List products = [
    {
      'product_name': 'Apple Watch',
      'image': 'assets/images/watch.png',
      'price': '\$ 88.45',
      'description': 'Series 6 Red'
    },
    {
      'product_name': 'Cosmetics',
      'image': 'assets/images/cosmetics.png',
      'price': '\$ 38.45',
      'description': 'All the new collections',
    },
    {
      'product_name': 'Iphone-13',
      'image': 'assets/images/iphone-13.webp',
      'price': '\$ 1200',
      'description': 'Only white & Black colour available',
    },
    {
      'product_name': 'Macbook air 13"',
      'image': 'assets/images/macbookair.png',
      'price': '\$ 1000',
      'description': '3 colors available',
    },
    {
      'product_name': 'Gaming Mouse',
      'image': 'assets/images/mouse.png',
      'price': '\$ 80',
      'description': '2 years warrenty',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
          ),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            'Hello Afran.',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Let’s gets something?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Divider(
                          color: Colors.transparent,
                        ),
                        carouselSlided(),
                        Divider(
                          color: Colors.transparent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Categories',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 25,
                              ),
                              child: Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  right: 8,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    categories[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.only(
                right: 25,
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
                            vertical: 20,
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
        ),
      ),
    );
  }
}

Widget carouselSlided() {
  return Container(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (_, index) {
        return Container(
          height: 120,
          width: 280,
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.only(top: 10, left: 15),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '40% Off During\nCovid 19',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/fruits-and-vegetables.png',
                  width: 110,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
