import 'package:ecommerce_app/app/views/mobileView/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:entry/entry.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  String _status = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
            title: 'MyShop',
            image: Image.asset("assets/icons/bag.gif", height: 175.0),
            bodyWidget: const Column(
              children: [
                Entry.all(
                  child: Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('"Welcome to MY SHOP! Your one-stop shop for everything you need, all in one place. Shop smart, shop fast, shop with ease."',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green
                        ),),
                      ),
                    ),
                  ),
                )
              ],
            ),


        ),
        PageViewModel(
            title: 'Fast And Convenient',
          bodyWidget: const Text('Effortless Shopping at Your Fingertips! Watch your cart fill with amazing deals as you browse through a world of possibilities.',
                    style:TextStyle(
                        fontSize: 17,
                        color: Colors.green
                    )
                  ),
            image: Card(
                elevation: 3,
                child: Image.asset('assets/icons/grocery.gif', fit: BoxFit.fill, width: double.infinity * 0.8),
            ),
        )

      ],
      showNextButton: true,
      showDoneButton: true,
      skip: const Text("Skip"),
      next: const Text('Next'),
      done: const Text("Done"),
      onDone: () {
        // On button pressed
        Get.to(() => LoginPage());
      },
    );
  }
}
