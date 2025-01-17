import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/flashProduct.dart';
import '../utils/api_constants.dart';

class FlashProductsController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  String url = APIConstants.products;
  @override
  void onInit(){
    super.onInit();
    fetchFlashProducts();
  }

  void fetchFlashProducts() async{
    try{
      final response = await http.get(Uri.parse(url));

      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        //print(data);
        products.value = data.map((json) => Product.fromJson(json)).toList();


      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }

     } catch (e){

        } finally {
          isLoading(false);
    }
    }

}