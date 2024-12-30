import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:ecommerce_app/app/views/CartsPage.dart';
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
                          label: const Text('Back to Cart', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4, wordSpacing: 2),),
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
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation:2,
                          color:Colors.orangeAccent,
                          child: ListTile(
                            leading: const Icon(Icons.info),
                            title: const Text('Please update personal information below.', style: TextStyle(fontSize: 12),),
                            trailing: IconButton(
                                onPressed:()async{
                                  await deliveryInfoController.loadFromSharedPreferences();
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (_) => DeliveryForm(),
                                  );
                                },
                                icon: const Icon(Icons.edit)
                            ),
                          ),
                        ),
                        const Text('Delivery Information.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('Name: ${ deliveryInfoController.fullName}'),
                        Text('Phone: ${ deliveryInfoController.phoneNumber}'),
                        Text('Email: ${ deliveryInfoController.email}'),
                        Text('Address: ${ deliveryInfoController.street},${deliveryInfoController.city}')

                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mode of Payment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        const Text('MPESA:'),
                        const TextField(

                        ),
                        const SizedBox(height: 15,),
                        ElevatedButton.icon(
                            onPressed: (){

                            },
                            icon: const Icon(Icons.mobile_screen_share_outlined),
                            label: const Text('Pay'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 20.0,
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
