import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/home_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter_uas/utils/number_format.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'inputWrapper.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());

  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;
  int index = 0;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Map<String, dynamic>> myList = [
    {
      // "Name": "Yovan Dermawan",
      // "Age": 20,
      "text": [
        "Kegiatan Sosial",
        "Zakat",
        "Bencana Alam",
        "Sekolah",
        "Rumah Ibadah",
        "Hewan",
        "Other",
      ],
      "category": [
        "images/Assets/category/social.png",
        "images/Assets/category/volunteer.png",
        "images/Assets/category/bencana-alam.png",
        "images/Assets/category/university.png",
        "images/Assets/category/mosque.png",
        "images/Assets/category/animals.png",
        "images/Assets/category/other.png",
      ],
      "colours": [
        Colors.red,
        Colors.blue.shade600,
        Colors.amber.shade600,
        Colors.purple,
      ],
    },
  ];

  final List banners = [
    "images/Assets/banners/1.png",
    "images/Assets/banners/2.png",
    "images/Assets/banners/3.png",
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // return GetBuilder<HomeController>(
    //     builder: ((controller) => RefreshIndicator(
    //           onRefresh: () => controller.refreshData(),
    //           child: CustomScrollView(
    //             slivers: <Widget>[
    //               SliverPersistentHeader(
    //                 delegate: CustomSliverAppBarDelegate(
    //                   expandedHeight: 160,
    //                 ),
    //               ),
    //               const SliverToBoxAdapter(
    //                 child: SizedBox(
    //                   height: 40,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )));
    return Container(
      color: Colors.grey.shade100,
      child: RefreshIndicator(
        onRefresh: () => homeController.refreshData(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(expandedHeight: 110),
            ),
            SliverToBoxAdapter(
                child: Container(
              height: 40,
              color: Colors.white,
            )),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: EdgeInsets.all(2),
                  color: Colors.white,
                  // height: 115,
                  // color: Colors.amber,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.only(left: 15, bottom: 10, top: 10),
                          child: Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Wrap(
                          runSpacing: 10,
                          children: myList[0]['category'].map<Widget>(
                            (category) {
                              var text_categories = myList[0]['text'];
                              var index =
                                  myList[0]['category'].indexOf(category);

                              return GestureDetector(
                                onTap: () {
                                  print("Container clicked ${category}");
                                  // productController
                                  //     .filterCategory(
                                  //         (index + 1).toString());
                                },
                                child: Container(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(15),
                                          margin: EdgeInsets.only(bottom: 10),
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.green
                                              // color: Colors.red
                                              ),
                                          // child: Image.asset(uri),
                                          child: Image.asset(
                                            category,
                                          )),
                                      Text(text_categories[index].toString(),
                                          textAlign: TextAlign.center)
                                      // Text("${data.categoryName}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                        // padding: EdgeInsets.all(10),

                        // height: 200,
                        height: (isLandscape)
                            ? mediaQueryHeight * 0.5
                            : mediaQueryHeight * 0.25,
                        // color: Colors.amber,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade400, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 10, bottom: 10, top: 10),
                                  child: Text(
                                    'Yuk... Mulai Berbagi Kebaikan',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                child: CarouselSlider(
                                  items: <Widget>[
                                    for (var i = 0; i < banners.length; i++)
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Get.toNamed('/banners/detail',
                                      //         arguments: productController
                                      //             .bannerModel.value?.body[i].id);
                                      //   },
                                      Container(
                                        height: 500,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              // image: AssetImage('images/Aset/Banner.png'),
                                              image: AssetImage(banners[i]),
                                            ),
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                    // )
                                  ],
                                  // items: productController.bannerModel?.body,
                                  // items: bannerWidget,
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      height: 500.0,
                                      // widht: 200,
                                      viewportFraction: 1.0,
                                      autoPlay: true,
                                      // enlargeCenterPage: true,
                                      // aspectRatio: 2.0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    (banners).asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: EdgeInsets.only(
                                          left: 4.0, right: 4.0, top: 5.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.green)
                                              .withOpacity(_current == entry.key
                                                  ? 0.9
                                                  : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ]),
                      ),
                    ],
                  )),
            ])),
            SliverToBoxAdapter(
                child: Container(
              height: 20,
            )),
            Obx(() => (homeController.isLoading.value == true)
                ? SliverToBoxAdapter(
                    child: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ))
                : _getSlivers(homeController))
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 60;
    final box = GetStorage();

    final top = expandedHeight - shrinkOffset - size / 2;
    final name = box.read('name');
    // final ProductController productController = Get.put(ProductController());
    // final name = (productController.memberModel.value?.body[0].name == null)
    //     ? ""
    //     : productController.memberModel.value?.body[0].name;
    // final points = (productController.memberModel.value?.body[0].points == null)
    //     ? 0
    //     : int.parse(productController.memberModel.value!.body[0].points);
    // final holdpoints =
    //     (productController.memberModel.value?.body[0].hold_points == null)
    //         ? 0
    //         : productController.memberModel.value?.body[0].hold_points;
    // final pointAccount = (points - holdpoints!);
    // final kurs_today = (productController.kursModel.value?.body[0].kurs == null)
    //     ? 0
    //     : productController.kursModel.value?.body[0].kurs;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset, name),
        // buildBackground(shrinkOffset, name, kurs_today),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
          // child: buildFloating(shrinkOffset, (pointAccount).toString()),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          // title: Text('Flutter'),
          centerTitle: false,
          backgroundColor: Colors.green,
        ),
      );

  Widget buildBackground(double shrinkOffset, String name) => Container(
        child: Opacity(
            opacity: disappear(shrinkOffset),
            child: AppBar(
              automaticallyImplyLeading: false,
              // title: Container(
              //     margin: EdgeInsets.only(top: 30),
              //     // padding: EdgeInsets.all(10),
              //     child: Column(
              //       children: [Text('Hai, Yovan D'), Text('Hai, Yovan D')],
              //     )),
              // centerTitle: false,
              flexibleSpace: Container(
                  child: Container(
                    // padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SafeArea(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 15,
                              left: 20,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Good Evening',
                                  //   style: TextStyle(
                                  //       fontSize: 20, color: Colors.white),
                                  // ),
                                  Text(
                                    'Hai, ' + name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            // top: 40,
                            right: 20,
                          ),
                          child: Icon(Icons.favorite, color: Colors.white),
                        )
                        // Stack(
                        //   alignment: AlignmentDirectional.topCenter,
                        //   children: [Text('Hey')],
                        // )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(20),
                    //     bottomRight: Radius.circular(20))
                  )),
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
            )),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        // Widget buildFloating(double shrinkOffset, String? pointAccount) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          elevation: 0,
          child: Row(
            children: [
              Expanded(child: buildButton()),
              // Expanded(child: buildButton(pointAccount)),
            ],
          ),
        ),
      );

  Widget buildButton() => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   style: BorderStyle.solid,
            //   color: Colors.black45,
            // ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.elliptical(5, 5))),
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(icon),
            // const SizedBox(width: 12),

            // Image(
            //   image: AssetImage('images/Aset/icon/points.png'),
            //   height: 30,
            // ),
            Row(
              children: [
                Icon(Icons.account_balance_wallet),
                Text("  10.000", style: TextStyle(fontSize: 16)),
              ],
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text("Isi",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),

            // Text(formatAmount((pointAccount).toString()),
            //     style: TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.red.shade800)),
          ],
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

Widget _getSlivers(homeController) {
  return SliverList(
    // I'm forcing item heights
    delegate: SliverChildBuilderDelegate(
      ((context, index) {
        // return;
        return GestureDetector(
          onTap: () {
            homeController.getDetail(
                (homeController.campaignModel.value?.body[index].slug)
                    .toString());
          },
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(15),

                height: 160,

                // color: Colors.amber,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey.shade400, width: 1),
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.5))
                    // borderRadius: BorderRadius.circular(10),
                    ),

                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          margin: EdgeInsets.only(bottom: 10, right: 10),
                          child: Image.network(
                            ApiEndPoints.baseUrlImage +
                                '/images/campaigns/' +
                                (homeController
                                        .campaignModel.value?.body[index].image)
                                    .toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  homeController
                                      .campaignModel.value?.body[index].name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey.shade400,
                                    color: Colors.green,
                                    value: (homeController
                                                .campaignModel
                                                .value
                                                ?.body[index]
                                                .total_collected_percentage)
                                            .toDouble() /
                                        100,
                                    minHeight: 5,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Terkumpul',
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            'Rp. ' +
                                                formatAmount((homeController
                                                        .campaignModel
                                                        .value
                                                        ?.body[index]
                                                        .total_collected)
                                                    .toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Sisa Hari'),
                                          Text('30',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ])
                                  ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        );
      }),
      childCount: homeController.campaignModel.value?.body.length ?? 0,
    ),
  );
}
