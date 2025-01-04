import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:ecommerce_app/app/widgets/StarRatingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:entry/entry.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../controllers/CartController.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final String slug;
  final double price;
  final String productDescription;
  ProductDetailScreen({
    required this.productName,
    required this.imageUrl,
    required this.slug,
    required this.price,
    required this.productDescription,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final CartController cartController = Get.find();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  var visible = true;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return AddToCartAnimation(
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.productName),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.cleaning_services),
              onPressed: () {
                setState(() {
                  _cartQuantityItems = 0;
                });
                cartKey.currentState?.runClearCartAnimation();
              },
            ),
            GestureDetector(
              onTap: (){
                print('Cart pressed');
              },
              child: AddToCartIcon(
                key: cartKey,
                icon: const Icon(Icons.shopping_cart),
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: ListView(
          children: [
            Entry.opacity(
              visible: visible,
              duration: const Duration(seconds: 3),
              child: Card(
                elevation: 4,
                child: Hero(
                  tag: widget.slug,
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.productName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            StarRatingWidget(),
            SizedBox(height: 10,),
            Entry.all(
              visible: visible,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.price}"),
                    )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(widget.productDescription),
                ],
              ),
            ),
            Entry.offset(
              visible: visible,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AddCartButton(
                  onClick: listClick,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  void listClick(GlobalKey widgetKey) async {
    cartController.addItem(
        widget.slug,
        widget.imageUrl,
        widget.productName,
        widget.price
    );
    await runAddToCartAnimation(widgetKey);
    var itemcount=cartController.items.length;
    await cartKey.currentState!
        .runCartAnimation((itemcount).toString());
  }
}
class AddCartButton extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AddCartButton({super.key, required this.onClick, });
  @override
  Widget build(BuildContext context) {
    //  Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: widgetKey,
      width: 50,
      height: 40,
      color: Colors.transparent,
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
        size: 35.0,
      )
    );

    return ElevatedButton.icon(
      onPressed: (){
        onClick(widgetKey);
      },
      icon: mandatoryContainer,//const Icon(Icons.shopping_cart),
      label: const Text('Add to Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),) ,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        backgroundColor: Colors.lightGreenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      //child: mandatoryContainer,
    );
  }
}