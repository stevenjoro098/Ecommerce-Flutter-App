import 'package:ecommerce_app/app/controllers/CartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/IconButtonWithText.dart';
import '../../../widgets/HomeWidgets/HomeView.dart';
import '../../CategoriesPage.dart';
import '../../../controllers/CartController.dart';

import '../../CartsPage.dart';

class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final CartController cartController = Get.find();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomButtonPressed(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeView(),
          CategoryPage(),
          CartPage(),
          Center(child: Text('Favorites Page', style: TextStyle(fontSize: 24))),
          Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),

        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: (){
                  _onBottomButtonPressed(0);
            },
                icon: const Icon(Icons.home_outlined)
            ),
            IconButton(onPressed: (){
              _onBottomButtonPressed(1);
            },
                icon: const Icon(Icons.category)
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Add your cart action here
                    _onBottomButtonPressed(2);
                  },
                ),
                if (2 > 0) // Only show badge if count > 0
                  Obx((){
                    return Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cartController.items.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  })
                  ,
              ],
            ),
            IconButton(onPressed: (){
              _onBottomButtonPressed(3);
            },
                icon: const Icon(Icons.favorite)
            ),
            IconButton(onPressed: (){
              _onBottomButtonPressed(4);
            },
                icon: const Icon(Icons.account_circle_outlined)
            )
          ],
        ),
      ),
    );
  }
}
