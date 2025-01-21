import 'dart:math';
import 'package:ecommerce_app/app/controllers/categoryController.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ProductsList.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  final CategoryController categoryController = Get.find();
  final random = Random();

  void initialize(BuildContext context) {
    categoryController.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initialize(context));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Decide layout based on screen width
          bool isTablet = constraints.maxWidth > 600; // Example breakpoint

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isTablet
                  ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryController.posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio: 3, // Adjust height of items
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  var category = categoryController.posts[index];
                  return Entry.all(
                    delay: Duration(milliseconds: random.nextInt(500)),
                    child: Card(
                      elevation: 1,
                      child: ListTile(
                        leading: Container(
                          child: Image.network(category.iconPath),
                        ),
                        title: Text(
                          category.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Get.to(() => ProductsListPageView(
                            categoryName: category.slug,
                          ));
                        },
                      ),
                    ),
                  );
                },
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoryController.posts.length,
                itemBuilder: (context, index) {
                  var category = categoryController.posts[index];
                  return Entry.all(
                    delay: Duration(milliseconds: random.nextInt(500)),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      child: Card(
                        elevation: 1,
                        child: ListTile(
                          leading: Container(
                              child: Image.network(category.iconPath)),
                          title: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: () {
                            Get.to(() => ProductsListPageView(
                              categoryName: category.slug,
                            ));
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
