import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/modelClass/modelClass.dart';

class DetailPage extends StatelessWidget {
  final Restaurants? restaurant;
  final String? image;

  const DetailPage({Key? key, this.restaurant, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double averageRating = calculateAverageRating(restaurant!.reviews!);
    RxDouble avgRating = averageRating.obs;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
      final RxBool showFullComment = false.obs; // Initialize with false
    String formatOperatingTime(String time) {
      return time.replaceAll("=>", ":");
    }

     void toggleFullComment() {
      showFullComment.value = !showFullComment.value;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          Container(
            height: height / 3,
            width: width,
            decoration: BoxDecoration(),
            child: Image.asset(
              '${image}',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${restaurant?.name ?? "Unknown"}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 24, 109, 8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() {
                          return Text(
                            "${avgRating.value.toString().length >= 3 ? avgRating.value.toString().substring(0, 3) : avgRating.value.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          );
                        }),
                        Icon(
                          Icons.star,
                          size: 17,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text('${restaurant?.cuisineType ?? "Unknown"}'),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text('${restaurant?.address ?? "Unknown"}'),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text(
              'Operating Hours:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          if (restaurant?.operatingHours != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Monday: ${formatOperatingTime(restaurant!.operatingHours!.monday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Tuesday: ${formatOperatingTime(restaurant!.operatingHours!.tuesday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Wednesday: ${formatOperatingTime(restaurant!.operatingHours!.wednesday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Thursday: ${formatOperatingTime(restaurant!.operatingHours!.thursday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Friday: ${formatOperatingTime(restaurant!.operatingHours!.friday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Saturday: ${formatOperatingTime(restaurant!.operatingHours!.saturday!) ?? "Closed"}'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text(
                  'Sunday: ${formatOperatingTime(restaurant!.operatingHours!.sunday!) ?? "Closed"}'),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Text('Operating hours not available'),
            ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Text(
              'Rating And Review',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restaurant!.reviews!.length,
            itemBuilder: (context, index) {
              final Reviews? review = restaurant!.reviews![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 24, 109, 8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  review != null
                                      ? review.rating.toString()
                                      : 'No Rating',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${review!.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display full or trimmed comment based on showFullComment
                Obx(() {
                  final String trimmedComment = review!.comments!.split(' ').take(50).join(' ') +
                      (review.comments!.length > 50 ? '...' : '');
                  return Text(
                    showFullComment.value ? '${review!.comments}' : trimmedComment,
                  );
                }),
                // Show "See more" text if the comment is trimmed
                if (review.comments!.length > 50)
                  GestureDetector(
                    onTap: () {
                      // Toggle showFullComment to display or hide full comment
                    toggleFullComment();
                    },
                    child: Obx(()=>
                       Text(
                        showFullComment.value==true ? 'See less' : 'See more',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
              ],
            ),
          ),

                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 6),
                    child: Text('${review!.date}'),
                  ),
                  Divider()
                ],
              );
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     // Navigate back to the previous page
          //     Get.back();
          //   },
          //   child: Text('Go Back'),
          // ),
        ],
      ),
    );
  }

  double calculateAverageRating(List<Reviews> reviews) {
    double totalRating = 0.0;

    // Sum up all the ratings
    for (var review in reviews) {
      totalRating += review.rating!.toDouble();
    }

    // Calculate the average rating
    double averageRating = totalRating / reviews.length;

    return averageRating;
  }
}
