import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:ecommerce_app/app/controllers/OrdersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/DeliveryForm.dart';
import 'mobileView/OrdersPage.dart';

class ProfilePageView extends StatefulWidget {
   ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final DeliveryInfoController deliveryInfoController = Get.find();
  final OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.outlined(
              onPressed: ()async {
                await deliveryInfoController.loadFromSharedPreferences();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => UserDetailsForm(),
                );
              },
              icon: const Icon(Icons.edit)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: const CircleAvatar(
                              child: Icon(Icons.account_circle_outlined, size: 60,),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(deliveryInfoController.fullName.value, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(deliveryInfoController.email.value,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        Text(deliveryInfoController.phoneNumber.value, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        Text("${deliveryInfoController.street.value} ${deliveryInfoController.city.value}",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Obx((){
                    if(orderController.ordersList.isEmpty){
                       return const Card(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  Text('Orders History', style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),),

                                  Text('No Orders Available',
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          fontSize: 23)),
                                ],
                              )
                          )
                      );
                    } else
                      {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Orders History', style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orderController.ordersList.length,
                                  itemBuilder: (context, index) {
                                    var order = orderController
                                        .ordersList[index];
                                    return Card(
                                      elevation: 2,
                                      child: ListTile(
                                        onTap: () {
                                          Get.to(() =>
                                              OrdersPageView(
                                                  orderCode: order.orderCode,
                                                  firstName: order.userFullName,
                                                  email: order.email,
                                                  address: order.address,
                                                  total: order.totalPrice,
                                                  created: order.orderDate
                                                      .toString(),
                                                  paid: order.paid
                                              ));
                                        },
                                        title: Text(
                                            "Order Code: ${order.orderCode}"),
                                        subtitle: Text(
                                            "Amount: ${order.totalPrice}"),
                                        trailing: (order.paid)
                                            ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius
                                                  .circular(20)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Paid'),
                                          ),
                                        )
                                            : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius: BorderRadius
                                                  .circular(20)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('UnPaid'),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        );
                      }
                  }),





                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
