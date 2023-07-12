// ignore_for_file: prefer_const_constructors

// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_uas/controllers/account_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';

// import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:surya_remmitance/controllers/account_controller.dart';
// import 'package:surya_remmitance/controllers/detailproduct_controller.dart';

// import 'package:surya_remmitance/controllers/product_controller.dart';
// import 'package:surya_remmitance/controllers/savedproduct_controller.dart';
// import 'package:surya_remmitance/utils/api_endpoints.dart';
// import 'package:surya_remmitance/utils/number_format.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;
  int index = 0;

  int _current = 0;
  final CarouselController _controller = CarouselController();
  // final ProductController productController = Get.put(ProductController());
  final AccountController accountController = Get.put(AccountController());

  // final DetailProductController detailproductController =
  //     Get.put(DetailProductController());

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            'My Account',
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
        // const SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 20,
        //   ),
        // ),
        Obx(() => (accountController.isLoading.value == true)
            ? SliverToBoxAdapter(
                child: Center(
                child: CircularProgressIndicator(color: Colors.green),
              ))
            : SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),

                    // padding: EdgeInsets.all(10),

                    height: 220,
                    // color: Colors.amber,

                    child: Column(children: [
                      ListTile(
                          title: Text(
                            (accountController.memberModel.value?.body[0].name)
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                (accountController
                                        .memberModel.value?.body[0].mobile)
                                    .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                (accountController
                                        .memberModel.value?.body[0].email)
                                    .toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          leading: CircleAvatar(
                            minRadius: 30,
                            maxRadius: 30,
                            child: ClipOval(
                              child:
                                  // Image.network(
                                  //   ApiEndPoints.baseUrlImage +
                                  //       "/profile_pictures/" +
                                  //       accountController
                                  //           .memberModel.value!.body[0].image,
                                  //   width: 100,
                                  //   height: 100,
                                  //   fit: BoxFit.cover,
                                  // ),

                                  // Container(
                                  //     width: 100,
                                  //     height: 100,
                                  //     color: Colors.green)
                                  Image.network(
                                ApiEndPoints.baseUrlImage +
                                    "/images/avatar/" +
                                    accountController
                                        .memberModel.value!.body[0].image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () => {
                                    accountController.nameController.text =
                                        accountController
                                            .memberModel.value!.body[0].name,
                                    accountController.emailController.text =
                                        accountController
                                            .memberModel.value!.body[0].email,
                                    accountController.phoneController.text =
                                        accountController
                                            .memberModel.value!.body[0].mobile,
                                    accountController.addressController.text =
                                        (accountController.memberModel.value!
                                                    .body[0].address ==
                                                null)
                                            ? ""
                                            : (accountController.memberModel
                                                    .value?.body[0].address)
                                                .toString(),
                                    accountController.addressController.text =
                                        (accountController.memberModel.value
                                                    ?.body[0].address !=
                                                null)
                                            ? (accountController.memberModel
                                                    .value!.body[0].address)
                                                .toString()
                                            : "",
                                    Get.toNamed('/account/edit')
                                  },
                              icon: Icon(Icons.edit))),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                  Container(
                    height: 10,
                    color: Colors.white,
                  ),

                  // Text((productController.productModel?.body[index].id).toString()),
                ]),
              )),

        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

            // color: Colors.amber,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () => {
                // DetailProductController().movePage()
                accountController.logout()
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]))
        // _getSlivers(productController),
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
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
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
          backgroundColor: Colors.red.shade800,
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
                        Container(
                          margin: EdgeInsets.only(
                            top: 40,
                            left: 20,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Evening',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'Yovan D',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          child: Image(
                            image: AssetImage(
                                'images/Aset/saved_Illustration.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)))),
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
            )),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          elevation: 0,
          child: Row(
            children: [
              Expanded(child: buildButton()),
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
            Row(
              children: [
                Image(
                  image: AssetImage('images/Aset/icon/points.png'),
                  height: 30,
                ),
                Text("  Your Points ", style: TextStyle(fontSize: 16)),
              ],
            ),

            Text("10.000",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade800)),
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

// class ClipPathClass extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height - 40);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height - 40);
//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// SliverList _getSlivers(accountController) {
//   if (accountController.isLoading.value != false) {
//     return SliverList(
//         delegate: SliverChildListDelegate([
//       Container(
//           child: ProfileShimmer(
//         isRectBox: true,
//       ))
//     ]));
//   } else
//     return SliverList(
//       // I'm forcing item heights
//       delegate: SliverChildBuilderDelegate(
//         ((context, index) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

//             // color: Colors.amber,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade400, width: 1),
//               borderRadius: BorderRadius.circular(10),
//             ),

//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                         margin: EdgeInsets.only(bottom: 10, right: 10),
//                         height: 80,
//                         width: 80,
//                         color: Colors.blue),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             child: Text(
//                               "Nike Air Jordan",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                               child: Text('Today',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                   ))),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     color: Colors.green[300],
//                                     padding: EdgeInsets.all(5),
//                                     child: Text('Redeem',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Color.fromARGB(
//                                                 255, 41, 90, 43)))),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 // ElevatedButton(
//                 //   style: ElevatedButton.styleFrom(
//                 //     primary: Colors.blue,
//                 //     minimumSize: const Size.fromHeight(50), // NEW
//                 //   ),
//                 //   onPressed: () {
//                 //     // Navigator.of(context).push(MaterialPageRoute(
//                 //     //   builder: (context) {
//                 //     //     return detailPage(
//                 //     //         id: '2',
//                 //     //         title: 'Nike Air Force',
//                 //     //         points: '10.000 Points',
//                 //     //         due_dates: '1 days left',
//                 //     //         image: 'nike2.jpg');
//                 //     //   },
//                 //     // ));
//                 //   },
//                 //   child: const Text(
//                 //     'Redeem Now',
//                 //     style: TextStyle(fontSize: 20),
//                 //   ),
//                 // ),
//               ],
//             ),
//           );
//         }),
//         childCount: accountController.transactionModel.value?.body.length ?? 0,
//       ),
//     );
// }
