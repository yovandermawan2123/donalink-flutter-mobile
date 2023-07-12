import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/home_controller.dart';
import 'package:flutter_uas/controllers/mydonation_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter_uas/utils/number_format.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'inputWrapper.dart';

class MyDonation extends StatefulWidget {
  @override
  State<MyDonation> createState() => _MyDonationState();
}

class _MyDonationState extends State<MyDonation> {
  final MyDonationController myDonationController =
      Get.put(MyDonationController());

  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;
  int index = 0;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // return GetBuilder<myDonationController>(
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            'My Donation',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          pinned: true,
          floating: false,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          //   color: Colors.red[800],
          // ),
          backgroundColor: Colors.white,
        ),
        Obx(() => (myDonationController.isLoading.value == true)
            ? SliverToBoxAdapter(
                child: Center(
                child: CircularProgressIndicator(color: Colors.green),
              ))
            : _getSlivers(myDonationController)),
      ],
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
        buildBackground(shrinkOffset),
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

  Widget buildBackground(double shrinkOffset) => Container(
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
                                    'Hai, User',
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

Widget _getSlivers(myDonationController) {
  return SliverList(
    // I'm forcing item heights
    delegate: SliverChildBuilderDelegate(
      ((context, index) {
        // return;
        return GestureDetector(
          onTap: () {
            myDonationController.getDetail((myDonationController
                    .donationModel.value?.body[index].campaign_slug)
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
                                (myDonationController.donationModel.value
                                        ?.body[index].campaign_image)
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
                                  myDonationController.donationModel.value
                                      ?.body[index].campaign_name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                child: Text(
                                  myDonationController.donationModel.value
                                      ?.body[index].invoice_number,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Container(
                              //     margin: EdgeInsets.symmetric(vertical: 10),
                              //     child: LinearProgressIndicator(
                              //       backgroundColor: Colors.grey.shade400,
                              //       color: Colors.green,
                              //       value: (myDonationController
                              //                   .donationModel
                              //                   .value
                              //                   ?.body[index]
                              //                   .total_collected_percentage)
                              //               .toDouble() /
                              //           100,
                              //       minHeight: 5,
                              //     )),
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
                                            'Jumlah Donasi',
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            'Rp. ' +
                                                formatAmount(
                                                    (myDonationController
                                                            .donationModel
                                                            .value
                                                            ?.body[index]
                                                            .amount)
                                                        .toString()),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Status'),
                                          Text(
                                              myDonationController.donationModel
                                                  .value?.body[index].status,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: myDonationController
                                                              .donationModel
                                                              .value
                                                              ?.body[index]
                                                              .status ==
                                                          'paid'
                                                      ? Colors.green
                                                      : Colors.red)),
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
      childCount: myDonationController.donationModel.value?.body.length ?? 0,
    ),
  );
}
