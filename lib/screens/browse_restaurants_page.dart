import 'package:flutter/material.dart';

class BrowseRestaurantsPage extends StatefulWidget {
  const BrowseRestaurantsPage({super.key});

  @override
  State<BrowseRestaurantsPage> createState() => _BrowseRestaurantsPageState();
}

class _BrowseRestaurantsPageState extends State<BrowseRestaurantsPage> {
  String selectedCategory = "All";
  final TextEditingController searchController = TextEditingController();

  // Dummy Data
  final List<String> categories = [
    "All",
    "Pizza",
    "Burger",
    "Drinks",
    "Dessert",
  ];

  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Pizza Palace",
      "category": "Pizza",
      "menu": [
        {
          "name": "Margherita",
          "price": 199,
          "image": "assets/images/pizza.png",
        },
        {"name": "Pepperoni", "price": 249, "image": "assets/images/foods.png"},
        {"name": "Deluxe", "price": 299, "image": "assets/images/foods6.png"},
        {"name": "Veggie", "price": 229, "image": "assets/images/foods7.png"},
      ],
    },
    {
      "name": "Burger House",
      "category": "Burger",
      "menu": [
        {
          "name": "Cheese Burger",
          "price": 149,
          "image": "assets/images/burger.png",
        },
        {
          "name": "Double Patty",
          "price": 199,
          "image": "assets/images/foods1.png",
        },
        {"name": "Crispy", "price": 169, "image": "assets/images/foods5.png"},
        {"name": "Special", "price": 219, "image": "assets/images/foods4.png"},
      ],
    },
    {
      "name": "Cool Drinks",
      "category": "Drinks",
      "menu": [
        {"name": "Coca Cola", "price": 49, "image": "assets/images/drink.png"},
        {
          "name": "Lemon Soda",
          "price": 59,
          "image": "assets/images/foods2.png",
        },
        {
          "name": "Mango Juice",
          "price": 69,
          "image": "assets/images/foods6.png",
        },
        {
          "name": "Orange Fizz",
          "price": 79,
          "image": "assets/images/foods7.png",
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final filteredRestaurants = selectedCategory == "All"
        ? restaurants
        : restaurants
              .where((res) => res["category"] == selectedCategory)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("🍴 Browse Restaurants & Menu"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 900;
          bool isDesktop = constraints.maxWidth >= 900;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Search Box
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search food or restaurant...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              // 📂 Categories
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: selectedCategory == cat,
                        selectedColor: Colors.orangeAccent,
                        labelStyle: TextStyle(
                          color: selectedCategory == cat
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        onSelected: (_) =>
                            setState(() => selectedCategory = cat),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // 🍔 Restaurant & Menu List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = filteredRestaurants[index];
                    final menu =
                        restaurant["menu"] as List<Map<String, dynamic>>;

                    final filteredMenu = menu
                        .where(
                          (item) => item["name"].toLowerCase().contains(
                            searchController.text.toLowerCase(),
                          ),
                        )
                        .toList();

                    if (filteredMenu.isEmpty) return const SizedBox();

                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        elevation: 6,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🏪 Restaurant Name
                              Text(
                                restaurant["name"],
                                style: TextStyle(
                                  fontSize: isDesktop
                                      ? 26
                                      : isTablet
                                      ? 22
                                      : 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // 📋 Menu Items Grid
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredMenu.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: isDesktop
                                          ? 4
                                          : isTablet
                                          ? 3
                                          : 2,
                                      childAspectRatio: 3 / 4,
                                      crossAxisSpacing: 14,
                                      mainAxisSpacing: 14,
                                    ),
                                itemBuilder: (context, i) {
                                  final item = filteredMenu[i];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 8,
                                          offset: const Offset(2, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(16),
                                                ),
                                            child: Image.asset(
                                              item["image"],
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                item["name"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: isDesktop ? 18 : 14,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "₹${item["price"]}",
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        "${item["name"]} added to cart 🛒",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orangeAccent,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: isDesktop
                                                        ? 20
                                                        : 12,
                                                    vertical: 8,
                                                  ),
                                                ),
                                                icon: const Icon(
                                                  Icons.add_shopping_cart,
                                                ),
                                                label: const Text("Add"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
