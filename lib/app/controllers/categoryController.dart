import 'package:ecommerce_app/app/models/category.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/api_constants.dart';

class CategoryController extends GetxController {
  var posts = <Category>[].obs; // Observable list of posts
  var isLoading = true.obs; // Observable loading state
  String url = APIConstants.categoryList;
  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // Fetch posts when the controller is initialized
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        //print(data);
        posts.value = data.map((json) => Category.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      //Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
