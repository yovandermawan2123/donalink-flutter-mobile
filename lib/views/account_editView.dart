// ignore_for_file: prefer_const_constructors

// import 'dart:ffi';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/account_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter_uas/views/widget/input_fields.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class AccountEditView extends StatefulWidget {
  const AccountEditView({Key? key}) : super(key: key);

  @override
  State<AccountEditView> createState() => _AccountEditViewState();
}

class _AccountEditViewState extends State<AccountEditView> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = true;
  int index = 0;

  int _current = 0;
  // final CarouselController _controller = CarouselController();
  final AccountController accountController = Get.put(AccountController());

  // final DetailProductController detailproductController =
  //     Get.put(DetailProductController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (controller) => Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              title: Text(
                'My Account',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              pinned: true,
              floating: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
            ),
            // const SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 20,
            //   ),
            // ),
            SliverList(
              delegate: SliverChildListDelegate([
                // CircleAvatar(
                //   // backgroundImage: ,
                //   minRadius: 30,
                //   maxRadius: 30,
                // ),
                Container(
                  child: accountController.image != null
                      ? CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.file(
                              controller.image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.network(
                              ApiEndPoints.baseUrlImage +
                                  "/images/avatar/" +
                                  accountController
                                      .memberModel.value!.body[0].image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Center(
                //     child: ElevatedButton(
                //   onPressed: () async {
                //     await controller.getImage();
                //   },
                //   child: Text("Upload Image"),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.green,
                //     // NEW
                //   ),
                // )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      InputTextFieldWidget(accountController.nameController,
                          'Name', 'false', ''),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(accountController.emailController,
                          'Email address', 'false', ''),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(accountController.phoneController,
                          'Number Phone', 'false', ''),
                      // InputTextFieldWidget(accountController.phoneController,
                      //     'Number Phone', 'false', '', true),
                      SizedBox(
                        height: 20,
                      ),
                      InputTextFieldWidget(accountController.addressController,
                          'Address', 'false', 'true'),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Center(
                    child: ElevatedButton(
                  onPressed: () async {
                    await accountController.updateProfile(
                        (accountController.box.read('id').toString()));
                  },
                  child: Text("Update Profile"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    // NEW
                  ),
                ))
                // Text((productController.productModel?.body[index].id).toString()),
              ]),
            ),
            // _getSlivers(productController),
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

// SliverList _getSlivers(productController) {
//   if (productController.isLoading != false) {
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
//           return Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 10),
//                 padding: EdgeInsets.all(15),

//                 height: 200,

//                 // color: Colors.amber,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey.shade400, width: 1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),

//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(bottom: 10, right: 10),
//                           child: Image.network(
//                             'https://suryamarket.org/upload_files/' +
//                                 (productController
//                                         .productModel?.body[index].image)
//                                     .toString(),
//                             fit: BoxFit.fill,
//                             height: 150,
//                           ),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                   padding: EdgeInsets.all(5),
//                                   height: 25,
//                                   decoration: BoxDecoration(
//                                       color: Color.fromARGB(207, 251, 155, 155),
//                                       borderRadius: BorderRadius.circular(5)),
//                                   child: Text(
//                                     '1 Days Left',
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 213, 92, 92),
//                                       fontSize: 12,
//                                     ),
//                                   )),
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 10),
//                                 child: Text(
//                                   (productController
//                                           .productModel?.body[index].name)
//                                       .toString(),
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(vertical: 10),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(right: 10),
//                                       child: Image(
//                                         image: AssetImage(
//                                             'images/Aset/icon/points.png'),
//                                         height: 20,
//                                       ),
//                                     ),
//                                     Text(
//                                         (productController.productModel
//                                                 ?.body[index].pointExchange)
//                                             .toString(),
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.red.shade800))
//                                   ],
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Container(
//                                   width: 150,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       primary: Colors.red.shade800,
//                                       minimumSize:
//                                           const Size.fromHeight(40), // NEW
//                                     ),
//                                     onPressed: () => {
//                                       productController.getDetail(
//                                           (productController
//                                                   .productModel?.body[index].id)
//                                               .toString()),
//                                     },
//                                     child: const Text(
//                                       'Redeem Now',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     // ElevatedButton(
//                     //   style: ElevatedButton.styleFrom(
//                     //     primary: Colors.blue,
//                     //     minimumSize: const Size.fromHeight(50), // NEW
//                     //   ),
//                     //   onPressed: () {
//                     //     // Navigator.of(context).push(MaterialPageRoute(
//                     //     //   builder: (context) {
//                     //     //     return detailPage(
//                     //     //         id: '2',
//                     //     //         title: 'Nike Air Force',
//                     //     //         points: '10.000 Points',
//                     //     //         due_dates: '1 days left',
//                     //     //         image: 'nike2.jpg');
//                     //     //   },
//                     //     // ));
//                     //   },
//                     //   child: const Text(
//                     //     'Redeem Now',
//                     //     style: TextStyle(fontSize: 20),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 10,
//                 color: Colors.white,
//               ),
//             ],
//           );
//         }),
//         childCount: productController.productModel?.body.length ?? 0,
//       ),
//     );
// }
