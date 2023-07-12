import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_uas/controllers/notification_controller.dart';
import 'package:flutter_uas/utils/api_endpoints.dart';
import 'package:flutter_uas/utils/number_format.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'inputWrapper.dart';

class NotificationView extends StatefulWidget {
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final NotificationController myNotificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    // return GetBuilder<myNotificationController>(
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
            'My Inbox',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          pinned: true,
          floating: false,
          elevation: 20,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          //   color: Colors.red[800],
          // ),
          backgroundColor: Colors.white,
        ),
        Obx(() => (myNotificationController.isLoading.value == true)
            ? SliverToBoxAdapter(
                child: Center(
                child: CircularProgressIndicator(color: Colors.green),
              ))
            : _getSlivers(myNotificationController)),
      ],
    );
  }

  _onDismissable(String id) {
    myNotificationController.onDismissed(id);
    final snackBar = SnackBar(
      content: Text('Berhasil menghapus pesan pada inbox'),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _getSlivers(myNotificationController) {
    return SliverList(
      // I'm forcing item heights
      delegate: SliverChildBuilderDelegate(
        ((context, index) {
          // return;
          return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: const ValueKey(0),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {}),

                // All actions are defined in the children parameter.
                children: [
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: (context) => _onDismissable(
                        (myNotificationController
                                .notificationModel.value?.body[index].id)
                            .toString()),
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(myNotificationController
                    .notificationModel.value?.body[index].title),
                subtitle: Text(myNotificationController
                    .notificationModel.value?.body[index].description),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('images/Assets/notification-icon.png'),
                ),
              ));

          // return Column(
          //   children: [
          //     Container(
          //       margin: EdgeInsets.symmetric(horizontal: 10),
          //       padding: EdgeInsets.all(15),

          //       height: 160,

          //       // color: Colors.amber,
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           // border: Border.all(color: Colors.grey.shade400, width: 1),
          //           border: Border(
          //               bottom: BorderSide(color: Colors.black, width: 0.5))
          //           // borderRadius: BorderRadius.circular(10),
          //           ),

          //       child: Column(
          //         children: [
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               // Container(
          //               //     height: 110,
          //               //     margin: EdgeInsets.only(bottom: 10, right: 10),
          //               //     child: Icon(Icons.notifications)),
          //               Expanded(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       child: Text(
          //                         myNotificationController
          //                             .notificationModel.value?.body[index].title,
          //                         style: TextStyle(fontSize: 16),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 20,
          //                     ),

          //                     Container(
          //                       child: Text(
          //                         myNotificationController.notificationModel.value
          //                             ?.body[index].description,
          //                         style: TextStyle(fontWeight: FontWeight.bold),
          //                       ),
          //                     ),
          //                     // Container(
          //                     //     margin: EdgeInsets.symmetric(vertical: 10),
          //                     //     child: LinearProgressIndicator(
          //                     //       backgroundColor: Colors.grey.shade400,
          //                     //       color: Colors.green,
          //                     //       value: (myNotificationController
          //                     //                   .notificationModel
          //                     //                   .value
          //                     //                   ?.body[index]
          //                     //                   .total_collected_percentage)
          //                     //               .toDouble() /
          //                     //           100,
          //                     //       minHeight: 5,
          //                     //     )),
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Column(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [SizedBox()]),
          //                           Column(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               children: [
          //                                 Text('Tanggal'),
          //                                 Text(
          //                                   (myNotificationController
          //                                           .notificationModel
          //                                           .value
          //                                           ?.body[index]
          //                                           .createdAt)
          //                                       .toString(),
          //                                 ),
          //                               ])
          //                         ])
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       height: 10,
          //       color: Colors.white,
          //     ),
          //   ],
          // );
        }),
        childCount:
            myNotificationController.notificationModel.value?.body.length ?? 0,
      ),
    );
  }
}
