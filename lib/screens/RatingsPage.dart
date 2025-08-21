import 'package:flutter/material.dart';

class RatingsPage extends StatefulWidget {
  final String restaurantName;
  final List<String> foodItems;

  RatingsPage({required this.restaurantName, required this.foodItems});

  @override
  _RatingsPageState createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  double restaurantRating = 0;
  String restaurantReview = "";
  List<Map<String, dynamic>> reviewList = [];

  Map<String, double> foodRatings = {};
  Map<String, String> foodReviews = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.foodItems) {
      foodRatings[item] = 0;
      foodReviews[item] = "";
    }
  }

  Widget buildRatingStars(
    double rating,
    Function(double) onChanged,
    double iconSize,
  ) {
    return Row(
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: iconSize,
          ),
          onPressed: () => onChanged(index + 1.0),
        );
      }),
    );
  }

  double calculateAverageRating() {
    if (reviewList.isEmpty) return 0;
    double total = reviewList.fold(0, (sum, r) => sum + r["rating"]);
    return total / reviewList.length;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ratings & Reviews"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                reviewList.sort((a, b) => b["rating"].compareTo(a["rating"]));
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐ Average Rating
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: isTablet ? 32 : 24),
                SizedBox(width: 6),
                Text(
                  calculateAverageRating().toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "Avg Rating",
                  style: TextStyle(fontSize: isTablet ? 18 : 14),
                ),
              ],
            ),
            Divider(),

            // Restaurant Rating
            Text(
              "Rate ${widget.restaurantName}",
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildRatingStars(
              restaurantRating,
              (value) => setState(() => restaurantRating = value),
              isTablet ? 36 : 28,
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Write your review for restaurant",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => restaurantReview = value,
            ),
            SizedBox(height: 20),

            // Food Ratings
            Text(
              "Rate Food Items",
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            ...widget.foodItems.map((item) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildRatingStars(
                        foodRatings[item]!,
                        (value) => setState(() => foodRatings[item] = value),
                        isTablet ? 30 : 24,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Write review for $item",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => foodReviews[item] = value,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.check, color: Colors.white),
                label: Text(
                  "Submit Ratings",
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 14,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    reviewList.add({
                      "rating": restaurantRating,
                      "review": restaurantReview,
                      "likes": 0,
                      "dislikes": 0,
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Thank you for your feedback! 🎉")),
                  );
                },
              ),
            ),

            SizedBox(height: 30),

            // Display Reviews
            Text(
              "User Reviews",
              style: TextStyle(
                fontSize: isTablet ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ...reviewList.map((r) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(
                    r["review"],
                    style: TextStyle(fontSize: isTablet ? 16 : 14),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(r["rating"].toStringAsFixed(1)),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.thumb_up, color: Colors.green),
                        onPressed: () => setState(() => r["likes"]++),
                      ),
                      Text("${r["likes"]}"),
                      IconButton(
                        icon: Icon(Icons.thumb_down, color: Colors.red),
                        onPressed: () => setState(() => r["dislikes"]++),
                      ),
                      Text("${r["dislikes"]}"),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
