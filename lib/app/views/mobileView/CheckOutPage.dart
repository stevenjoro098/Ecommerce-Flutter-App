import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:ecommerce_app/app/controllers/OrdersController.dart';
import 'package:ecommerce_app/app/views/mobileView/CartsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/DeliveryForm.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final CartController cartController = Get.find();
  final DeliveryInfoController deliveryInfoController = Get.find();
  final OrderController orderController = Get.find();
  @override
  void dispose(){
    super.dispose();
    cartController.clearCart();
    deliveryInfoController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout')
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Total: ${cartController.totalAmount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartController.items.length,
                            itemBuilder: (context, index){
                            var item = cartController.items.values.toList()[index];
                            num total = item.quantity * item.price;
                            orderController.addItem(item.slug, item.name,item.quantity.value, item.price);
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                  leading: ClipRRect(
                              
                                      child: Image.network(item.imageUrl),
                                  ),
                                  title: Text(item.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                                  subtitle: Text("Quantity: ${item.quantity.toString()}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),),
                                  trailing: Text("Ksh. ${ total.toString()}"),
                                ),
                            );
                        }),
                        const SizedBox(height: 10,),
                        ElevatedButton.icon(
                          onPressed: (){
                            Get.to(() => CartPage());
                          },
                          label: const Text('Back to Cart', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3, fontSize: 15),),
                            icon: const Icon(Icons.arrow_back_ios_sharp),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: Colors.lightGreenAccent,
                              minimumSize: const Size(double.infinity, 45),
                            ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation:2,
                            color:deliveryInfoController.isDataValid.value
                                ? Colors.orangeAccent
                                : Colors.blueGrey[200]
                            ,//Colors.orangeAccent,
                            child: ListTile(
                              leading: const Icon(Icons.info),
                              title: const Text('Update personal information below.', style: TextStyle(fontSize: 12),),
                              trailing: IconButton(
                                  onPressed:()async{
                                    await deliveryInfoController.loadFromSharedPreferences();
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (_) => UserDetailsForm(),
                                    );
                                  },
                                  icon: const Icon(Icons.edit)
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Delivery Information.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                Text('Name: ${ deliveryInfoController.fullName}'),
                                Text('Phone: ${ deliveryInfoController.phoneNumber}'),
                                Text('Email: ${ deliveryInfoController.email}'),
                                Text('Address: ${ deliveryInfoController.street},${deliveryInfoController.city}'),
                                const SizedBox(height: 10,),
                                ElevatedButton.icon(
                                    onPressed: (){
                                      orderController.placeOrder(
                                        deliveryInfoController.fullName.toString(),
                                        deliveryInfoController.phoneNumber.toString(),
                                        deliveryInfoController.email.toString(),
                                        deliveryInfoController.street.toString(),
                                        deliveryInfoController.city.toString()
                                      );


                                    },
                                    icon: const Icon(Icons.shopping_cart_checkout_sharp),
                                    label: const Text('Make Order'),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 18.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Colors.green
                                      ,
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
