import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareContentView extends StatelessWidget {
  const ShareContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1, // Adjust this for the height/width ratio
          ),
          children: [
            IconButton(onPressed: (){
              //Share.share('contentToShare', subject: "Share via WhatsApp");
            },
                icon: const Icon(FontAwesomeIcons.whatsapp,color: Colors.green,),
            ),
            IconButton(onPressed: (){},
                icon: const Icon(FontAwesomeIcons.instagram,color: Colors.purple,)
            ),
            IconButton(onPressed: (){},
                icon: const Icon(FontAwesomeIcons.message,color: Colors.blue,)
            ),
            IconButton(onPressed: (){},
                icon: const Icon(Icons.email)
            ),
            IconButton(onPressed: (){},
                icon: const Icon(Icons.link)
            )
          ],

        ),
      ),
    );
  }
}
