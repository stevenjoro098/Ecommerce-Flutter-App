import 'package:ecommerce_app/app/controllers/DeliveryInfoController.dart';
import 'package:ecommerce_app/app/widgets/HomeWidgets/PopularProductsList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../widgets/IconButtonCircularBg.dart';
import '../../widgets/SearchTextBar.dart';
import 'FlashproductListHome.dart';
import 'categoryListHome.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DeliveryInfoController deliveryInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40,),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularIconButton(
                          icon: Icons.settings, onPressed: (){

                      }
                      ),
                      Column(
                        children: [
                          Text(deliveryInfoController.fullName.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2),),
                          Text(deliveryInfoController.email.toString(), style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      CircularIconButton(
                          icon: Icons.notifications,
                          onPressed: (){

                          }
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SearchTextBar(),
                  ),
                ],
              ),
            ),
          ),
          // Set a fixed height for the expanded area
          SizedBox(
            height: MediaQuery.of(context).size.height * .7, // Adjust as needed
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See All...'),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: CategoryList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flash Sales',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)
                          ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                              child: Text('12:12:12'),
                            )
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See all'),
                        )
                      ],
                    ),
                    Expanded(
                      child: FlashProductGrid(),
                    ),


                  ],
                ),
              ),
            ),
          ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Popular',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .45,
                        child: PopularProductsList()
                    )
                    //PopularProductsList()
                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }
}
