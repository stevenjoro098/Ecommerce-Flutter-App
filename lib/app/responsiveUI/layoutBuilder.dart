import 'package:ecommerce_app/main.dart';
import 'package:flutter/material.dart';

import '../views/mobileView/Home/Home.dart';

import 'deviceWidths.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth < mobileWidth) {
            //For Mobile UI
            return SplashScreen();
          } else {
            return Column(
              children: [
                Expanded(child: Container(color: Colors.blue)),
                Expanded(child: Container(color: Colors.green)),
              ],
            );
          }

        })
    );
  }
}
