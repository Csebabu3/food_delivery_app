import 'package:flutter/material.dart';

class SearchFilterPage extends StatefulWidget {
  @override
  _SearchFilterPageState createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  String searchQuery = "";
  String selectedCuisine = "All";
  double selectedRating = 0;
  RangeValues priceRange = RangeValues(10, 100);
  String sortBy = "None";

  // 🔹 Configurable Cuisines & Sort Options
  final List<String> cuisines = [
    "All",
    "Pizza",
    "Burger",
    "Sandwich",
    "Mexican",
  ];
  final List<String> sortOptions = ["None", "Price", "Rating"];

  // 🔹 Sample data with images
  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Pizza Hut",
      "cuisine": "Pizza",
      "rating": 4.5,
      "price": 50,
      "image": "assets/images/pizza.png",
    },
    {
      "name": "Burger King",
      "cuisine": "Burger",
      "rating": 4.2,
      "price": 40,
      "image": "assets/images/burger.png",
    },
    {
      "name": "Domino's",
      "cuisine": "Pizza",
      "rating": 4.0,
      "price": 60,
      "image": "assets/images/foods.png",
    },
    {
      "name": "Subway",
      "cuisine": "Sandwich",
      "rating": 4.3,
      "price": 30,
      "image": "assets/images/foods1.png",
    },
    {
      "name": "Taco Bell",
      "cuisine": "Mexican",
      "rating": 4.1,
      "price": 35,
      "image": "assets/images/foods2.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = MediaQuery.of(context).size.width;

    // 🔹 Apply Filters
    List<Map<String, dynamic>> filteredList = restaurants.where((restaurant) {
      final matchesSearch = restaurant["name"].toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesCuisine =
          selectedCuisine == "All" || restaurant["cuisine"] == selectedCuisine;
      final matchesRating = restaurant["rating"] >= selectedRating;
      final matchesPrice =
          restaurant["price"] >= priceRange.start &&
          restaurant["price"] <= priceRange.end;
      return matchesSearch && matchesCuisine && matchesRating && matchesPrice;
    }).toList();

    // 🔹 Apply Sorting
    if (sortBy == "Price") {
      filteredList.sort((a, b) => a["price"].compareTo(b["price"]));
    } else if (sortBy == "Rating") {
      filteredList.sort((a, b) => b["rating"].compareTo(a["rating"]));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search & Filter"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Clear Filters",
            onPressed: _resetFilters,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 12),
            _buildFilters(screenWidth),
            SizedBox(height: 12),
            _buildRatingSlider(screenWidth),
            _buildPriceSlider(screenWidth),
            Divider(),
            _buildResultsList(filteredList),
          ],
        ),
      ),
    );
  }

  // 🔹 Search Bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search restaurants or food...",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) => setState(() => searchQuery = value),
    );
  }

  // 🔹 Cuisine & Sort Filters
  Widget _buildFilters(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: selectedCuisine,
            isExpanded: true,
            items: cuisines
                .map(
                  (cuisine) =>
                      DropdownMenuItem(value: cuisine, child: Text(cuisine)),
                )
                .toList(),
            onChanged: (value) => setState(() => selectedCuisine = value!),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: DropdownButton<String>(
            value: sortBy,
            isExpanded: true,
            items: sortOptions
                .map(
                  (sort) => DropdownMenuItem(
                    value: sort,
                    child: Text("Sort by $sort"),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => sortBy = value!),
          ),
        ),
      ],
    );
  }

  // 🔹 Rating Slider
  Widget _buildRatingSlider(double screenWidth) {
    return Row(
      children: [
        Text(
          "Min Rating: ",
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Slider(
            value: selectedRating,
            min: 0,
            max: 5,
            divisions: 5,
            label: "$selectedRating",
            onChanged: (value) => setState(() => selectedRating = value),
          ),
        ),
      ],
    );
  }

  // 🔹 Price Range
  Widget _buildPriceSlider(double screenWidth) {
    return Row(
      children: [
        Text(
          "Price Range: ",
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: RangeSlider(
            values: priceRange,
            min: 0,
            max: 200,
            divisions: 20,
            labels: RangeLabels(
              "\$${priceRange.start.round()}",
              "\$${priceRange.end.round()}",
            ),
            onChanged: (values) => setState(() => priceRange = values),
          ),
        ),
      ],
    );
  }

  // 🔹 Results Grid/List
  Widget _buildResultsList(List<Map<String, dynamic>> filteredList) {
    return Expanded(
      child: filteredList.isEmpty
          ? Center(child: Text("No results found"))
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Tablet/Web -> Grid
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 900 ? 3 : 2,
                      childAspectRatio: 3,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) =>
                        RestaurantCard(restaurant: filteredList[index]),
                  );
                } else {
                  // Mobile -> List
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) =>
                        RestaurantCard(restaurant: filteredList[index]),
                  );
                }
              },
            ),
    );
  }

  // 🔹 Reset Filters
  void _resetFilters() {
    setState(() {
      searchQuery = "";
      selectedCuisine = "All";
      selectedRating = 0;
      priceRange = RangeValues(10, 100);
      sortBy = "None";
    });
  }
}

// 🔹 Reusable Restaurant Card
class RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            restaurant["image"],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(restaurant["name"]),
        subtitle: Text(
          "${restaurant["cuisine"]} • ⭐ ${restaurant["rating"]} • \$${restaurant["price"]}",
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${restaurant["name"]} selected")),
          );
          // 🔹 Future: Navigate to restaurant details page
        },
      ),
    );
  }
}
