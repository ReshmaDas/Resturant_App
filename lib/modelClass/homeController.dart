import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/modelClass/modelClass.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getApiResponse();
    super.onInit();
  }

  var dataModel = RastaurantModelClass().obs;

  Future<void> getApiResponse() async {
    try {
      final response = await http.get(
        Uri.parse('https://firstflight-web.ipixsolutions.net/api/getRestaurants'),
       
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Decoded JSON data: $data');

        RastaurantModelClass dataApi = RastaurantModelClass.fromJson(data);
        dataModel.value = dataApi;
        print('Data model updated successfully');
      } else {
        print('Request failed with status: ${response.statusCode}');
      
      }
    } catch (e) {
      print('Error occurred: $e');
     
    }
  }

  
}
