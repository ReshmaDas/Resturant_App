import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/detailPage.dart';
import 'package:restaurant_app/modelClass/const.dart';
import 'package:restaurant_app/modelClass/homeController.dart';
import 'package:restaurant_app/modelClass/modelClass.dart';
import 'package:restaurant_app/modelClass/shared_pre.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height  = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: Colors.orange,
  title: Padding(
    padding: const EdgeInsets.only(top: 35),
    child: Text('RESTAURANT',style: TextStyle(color: Colors.white),),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: InkWell(
        onTap: () {
          SharedPrefrence().logout();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Row(
            children: [
              Icon(Icons.logout,color: Colors.white),
              Text('Logout',style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    ),
  ],
),

      body: ListView(
        children: [
          Container(
          //  margin: EdgeInsets.only(right: 10,bottom: 10),
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orange
            ),
            
          ),
          SizedBox(
            height: height - 30, 
            child: Obx(() {
              final List<Restaurants>? restaurants = homeController.dataModel.value.restaurants;
              
              if (restaurants == null || restaurants.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: restaurants!.length,
                  itemBuilder: (context, index) {
                    final Restaurants? restaurant = restaurants[index];
                    final Reviews? firstReview = restaurant!.reviews?.first; // Get the first review
                    final double? rating = firstReview?.rating as double?;
                    final String imageUrls = images![index];
                     final OperatingHours? operatingHours = restaurant!.operatingHours;
          
              String formatOperatingTime(String time) {
                return time.replaceAll("=>", ":");
              }
            
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Get.to(DetailPage(restaurant: restaurant,image: imageUrls,));
                          print('click');
                        },
                        child: Card(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          elevation: 4,
                          child: IntrinsicHeight(
                            child: Container(
                              //height: height *.8,
                              width: width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: Container(
                                      height: height / 3,
                                      width: width,
                                      decoration: BoxDecoration(),
                                      child: Image.asset(
                                        '${imageUrls}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                   SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10,left: 10),
                                    child: Row(
                                    //  crossAxisAlignment: Cross,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(restaurant.name ?? 'No Name',style: TextStyle(
                                          fontWeight: FontWeight.bold,fontSize: 18
                                        ),),
                                        SizedBox(width: 15),
                                        Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Color.fromARGB(255, 24, 109, 8)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(rating != null ? rating.toString() : 'No Rating',style: TextStyle(color: Colors.white,fontSize: 16),),
                                                Icon(Icons.star,
                                                size: 17,
                                                color: Colors.white,)
                                              ],
                                            ),
                                          )), // Display the rating
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 14,),
                                  Padding(
                                     padding:  EdgeInsets.only(right: 10,left: 10),
                                    child: Row(
                                      children: [
                                       Icon(restaurantIcon),
                                       SizedBox(width: 5,),
                            
                                        //  Icon(Icons.rat,
                                        //         size: 17,
                                        //         color: Colors.grey,),
                                        Text(restaurant.cuisineType ?? 'No cuisine Type',style: TextStyle(color: Colors.grey),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                   Padding(
                                     padding: const EdgeInsets.only(right: 10,left: 10,bottom: 10),
                                     child: Row(
                                      children: [
                                         Icon(Icons.location_pin),
                                         SizedBox(width: 5,),
                                        Text(restaurant.address ?? 'No Address'),
                                      ],
                                                                       ),
                                   ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

   List<String>? images=['asset/pic1.jpeg',
   'asset/pic2.jpeg',
   'asset/pic3.jpeg',
   'asset/pic4.jpeg',
   'asset/pic5.jpeg',
   'asset/pic6.jpeg',
   'asset/pic7.jpeg',
   'asset/pic1.jpeg',
   'asset/pic2.jpeg',
   'asset/pic3.jpeg',
   'asset/pic4.jpeg',
   'asset/pic5.jpeg',
   'asset/pic6.jpeg',
   ];
}
