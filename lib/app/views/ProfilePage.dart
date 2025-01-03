import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:ecommerce_app/app/controllers/OrdersController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/DeliveryForm.dart';

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
        child: Column(
          children: [
            Column(
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
                const Align(
                  alignment: Alignment.centerLeft,
                    child: Text('Orders History')
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:orderController.ordersList.length,
                    itemBuilder: (context, index){
                    var order = orderController.ordersList[index];
                      return ListTile(
                        title: Text(order.orderCode),
                        subtitle: Text(order.totalPrice),
                      );
                })


              ],
            )
          ],
        ),
      ),
    );
  }
}
