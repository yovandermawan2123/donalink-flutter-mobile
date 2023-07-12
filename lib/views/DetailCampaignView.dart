import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_uas/controllers/detailcampaign_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter_uas/utils/number_format.dart';
import 'package:flutter_uas/views/widget/snap_midtrans.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class DetailCampaign extends StatefulWidget {
  const DetailCampaign({Key? key}) : super(key: key);
  @override
  State<DetailCampaign> createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign> {
  // const DetailCampaign({Key? key}) : super(key: key);
  final DetailCampaignController detailcampaignController =
      // Get.put(DetailCampaignController());
      Get.put(DetailCampaignController(Get.arguments));

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // print(detailproductController.getProductModel);

    return GetBuilder<DetailCampaignController>(
      builder: (contextX) {
        // var hold_quantity = (detailproductController
        //             .getProductModel.value?.body[0].hold_quantity ==
        //         null)
        //     ? 0
        //     : int.parse((detailproductController
        //             .getProductModel.value?.body[0].hold_quantity)
        //         .toString());

        // var total_quantity =
        //     (detailproductController.getProductModel.value?.body[0].quantity ==
        //             null)
        //         ? 0
        //         : int.parse(detailproductController
        //             .getProductModel.value!.body[0].quantity);

        return Obx(() => Container(
              color: Colors.white,
              child: (detailcampaignController.isLoading.value == true)
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          backgroundColor: Colors.white,
                          // pinned: true,
                          floating: true,
                          centerTitle: true,
                          title: Text(
                            'Detail Campaign',
                            style: TextStyle(color: Colors.black),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.back();
                            },
                            color: Colors.black,
                          ),
                          // actions: [
                          //   IconButton(
                          //       icon: Icon(
                          //           (savedproductController.selected == true)
                          //               ? Icons.favorite
                          //               : Icons.favorite_outline),
                          //       color: (savedproductController.selected == true)
                          //           ? Colors.red[800]
                          //           : Colors.black,
                          //       onPressed: () {
                          //         savedproductController.onTapSaved(
                          //             (detailproductController.getProductModel
                          //                     .value?.body[0].id)
                          //                 .toString(),
                          //             box.read('id').toString());
                          //       })
                          // ],
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(ApiEndPoints.baseUrlImage +
                                    '/images/campaigns/' +
                                    (detailcampaignController
                                            .campaignModel.value?.body[0].image)
                                        .toString()), //your image
                                fit: BoxFit.cover,
                              ),
                              // borderRadius: BorderRadius.vertical(
                              //   bottom: Radius.circular(50),
                              // ),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              width: double.infinity,
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Container(
                                        child: Text(
                                      (detailcampaignController.campaignModel
                                              .value?.body[0].name)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Arial'),
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Text('Terkumpul :',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Arial',
                                            color: Colors.black54)),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'Arial'),
                                        children: [
                                          TextSpan(
                                              text: ' Rp. ' +
                                                  formatAmount(
                                                      (detailcampaignController
                                                              .campaignModel
                                                              .value
                                                              ?.body[0]
                                                              .total_collected)
                                                          .toString()),
                                              style: TextStyle(
                                                  color: Colors.green))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey.shade400,
                                          color: Colors.green,
                                          value: (detailcampaignController
                                                      .campaignModel
                                                      .value!
                                                      .body[0]
                                                      .total_collected_percentage)
                                                  .toDouble() /
                                              100,
                                          minHeight: 15,
                                        )),
                                    // Container(
                                    //     child: Text(
                                    //   "Stok :" +
                                    //       (int.parse((detailproductController
                                    //                       .getProductModel
                                    //                       .value
                                    //                       ?.body[0]
                                    //                       .quantity)
                                    //                   .toString()) -
                                    //               int.parse(
                                    //                   (detailproductController
                                    //                           .getProductModel
                                    //                           .value
                                    //                           ?.body[0]
                                    //                           .hold_quantity)
                                    //                       .toString()))
                                    //           .toString(),
                                    //   style: TextStyle(
                                    //       fontSize: 14,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.black,
                                    //       decoration: TextDecoration.none,
                                    //       fontFamily: 'Arial'),
                                    // )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.grey.shade100,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Description',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'Arial'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              (detailcampaignController
                                                      .campaignModel
                                                      .value
                                                      ?.body[0]
                                                      .description)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'Arial'),
                                            )
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )),
                          // Container(
                          //   height: 10,
                          //   color: Colors.grey.shade100,
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 10),
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 10, vertical: 10),
                          //   child: Obx(() => Container(
                          //         color: Colors.grey.shade100,
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 20, vertical: 10),
                          //         child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 'Term & Condition',
                          //                 style: TextStyle(
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.bold,
                          //                     color: Colors.black,
                          //                     decoration: TextDecoration.none,
                          //                     fontFamily: 'Arial'),
                          //               ),
                          //               SizedBox(
                          //                 height: 10,
                          //               ),
                          //               Text(
                          //                 (detailproductController
                          //                         .getProductModel
                          //                         .value
                          //                         ?.body[0]
                          //                         .description)
                          //                     .toString(),
                          //                 style: TextStyle(
                          //                     fontSize: 14,
                          //                     fontWeight: FontWeight.normal,
                          //                     color: Colors.black,
                          //                     decoration: TextDecoration.none,
                          //                     fontFamily: 'Arial'),
                          //               )
                          //             ]),
                          //       )),
                          // ),
                          // SizedBox(
                          //   height: 40,
                          // ),
                          Center(
                            child: Container(
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: () => {
                                  Get.bottomSheet(Container(
                                    height: 380,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   'Pilih Mitra',
                                        //   style: TextStyle(
                                        //       fontSize: 14,
                                        //       fontWeight: FontWeight.bold),
                                        // ),

                                        Text(
                                          'Nominal',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        TextField(
                                            controller: detailcampaignController
                                                .amountController,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: InputBorder.none,
                                              hintText: 'Rp.',
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                // primary: Colors.green,
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('10000');
                                              },
                                              child: const Text(
                                                'Rp. 10.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('25000');
                                              },
                                              child: const Text(
                                                'Rp. 25.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('50000');
                                              },
                                              child: const Text(
                                                'Rp. 50.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                // primary: Colors.green,
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('75000');
                                              },
                                              child: const Text(
                                                'Rp. 75.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('100000');
                                              },
                                              child: const Text(
                                                'Rp. 100.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .green), // Atur lebar dan warna border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                primary: Colors.white,
                                                // NEW
                                              ),
                                              onPressed: () {
                                                detailcampaignController
                                                    .addAmount('150000');
                                              },
                                              child: const Text(
                                                'Rp. 150.000',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                        Center(
                                          child: Container(
                                            width: 250,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                minimumSize:
                                                    const Size.fromHeight(
                                                        50), // NEW
                                              ),
                                              onPressed: () async {
                                                //                                     Navigator.pushNamed(context, ScreenRouter.SNAP, arguments: <String, dynamic>{
                                                //   ScreenRouter.ARG_TRANSACTION_TOKEN: state.transactionToken,
                                                // });

                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         SnapScreen(
                                                //             transactionToken:
                                                //                 '0ed9bdbd-d9db-4c25-ace7-4a69ecb3a948'),
                                                //   ),
                                                // );

                                                final storeDonation =
                                                    await detailcampaignController
                                                        .storeDonation(
                                                            detailcampaignController
                                                                .campaignModel
                                                                .value
                                                                ?.body[0]
                                                                .id);

                                                final slug =
                                                    detailcampaignController
                                                        .campaignModel
                                                        .value!
                                                        .body[0]
                                                        .slug;

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SnapScreen(
                                                            transactionToken:
                                                                storeDonation,
                                                            slug: slug),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Selanjutnya',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                },
                                child: const Text(
                                  'Donasi',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ]))
                      ],
                    ),
            ));
      },
    );
  }
}
