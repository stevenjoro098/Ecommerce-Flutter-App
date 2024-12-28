import 'package:ecommerce_app/app/views/ProductsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../controllers/categoryController.dart';
import '../../controllers/ProductsController.dart';

import '../IconButtonWithText.dart';
class CategoryList extends StatefulWidget {
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final CategoryController postController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (postController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (postController.posts.isEmpty) {
        return const Center(child: Text('Data Unavailable'));
      }
      // Wrap ListView in SizedBox to constrain height
      return SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButtonWithText(
                    imagePath: post.iconPath,
                    label: post.name,
                    onPressed: (){
                      print(post.slug);
                      Get.to(()=> ProductsListPageView(categoryName: post.slug,));
                    },

              ),
            );
          },
        ),
      );
    });
  }
}
