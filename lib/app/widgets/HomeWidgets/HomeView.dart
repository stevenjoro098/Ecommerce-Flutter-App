import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/IconButtonCircularBg.dart';
import '../../widgets/SearchTextBar.dart';
import '../../widgets/IconButtonWithText.dart';
import 'FlashproductListHome.dart';
import 'categoryListHome.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularIconButton(
                      icon: Icons.settings,
                      onPressed: (){

                      }
                  ),
                  Column(
                    children: [
                      Text('Delivery Address'),
                      Text('92, High London'),
                    ],
                    ),
                  CircularIconButton(
                      icon: Icons.notifications,
                      onPressed: (){},
                      backgroundColor: Colors.white60,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchTextBar(

                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Category',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),),
                      TextButton(
                          onPressed: (){},
                          child: const Text('See All...'))
                    ],
                  ),
                  const SizedBox(height: 15,),
                  CategoryList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Flash Sales'),
                      const Chip(label: Text('12:12:12')),
                      TextButton(onPressed: (){},
                          child: const Text('See all')
                      )
                    ],
                  ),
                  FlashProductGrid()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
