import 'package:flutter/material.dart';

class RestaurantManagementPage extends StatefulWidget {
  @override
  _RestaurantManagementPageState createState() =>
      _RestaurantManagementPageState();
}

class _RestaurantManagementPageState extends State<RestaurantManagementPage> {
  List<Map<String, dynamic>> restaurants = [
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
  ];

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String cuisine = "";
  double rating = 0;
  double price = 0;

  void _showRestaurantDialog({Map<String, dynamic>? restaurant, int? index}) {
    if (restaurant != null) {
      name = restaurant["name"];
      cuisine = restaurant["cuisine"];
      rating = restaurant["rating"];
      price = restaurant["price"];
    } else {
      name = "";
      cuisine = "";
      rating = 0;
      price = 0;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            restaurant == null ? "Add Restaurant" : "Edit Restaurant",
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter restaurant name" : null,
                    onChanged: (val) => name = val,
                  ),
                  TextFormField(
                    initialValue: cuisine,
                    decoration: InputDecoration(labelText: "Cuisine"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter cuisine type" : null,
                    onChanged: (val) => cuisine = val,
                  ),
                  TextFormField(
                    initialValue: rating.toString(),
                    decoration: InputDecoration(labelText: "Rating"),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter rating" : null,
                    onChanged: (val) => rating = double.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    initialValue: price.toString(),
                    decoration: InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (value) => value!.isEmpty ? "Enter price" : null,
                    onChanged: (val) => price = double.tryParse(val) ?? 0,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text(restaurant == null ? "Add" : "Update"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (restaurant == null) {
                      restaurants.add({
                        "name": name,
                        "cuisine": cuisine,
                        "rating": rating,
                        "price": price,
                        "image": "assets/images/foods.png",
                      });
                    } else {
                      restaurants[index!] = {
                        "name": name,
                        "cuisine": cuisine,
                        "rating": rating,
                        "price": price,
                        "image": restaurant["image"],
                      };
                    }
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWide = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add Restaurant",
            onPressed: () => _showRestaurantDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: restaurants.isEmpty
            ? Center(child: Text("No restaurants added yet"))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 3 : 1,
                  childAspectRatio: isWide ? 3 : 3.5,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
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
                      title: Text(
                        restaurant["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${restaurant["cuisine"]} • ⭐ ${restaurant["rating"]} • ₹${restaurant["price"]}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _showRestaurantDialog(
                              restaurant: restaurant,
                              index: index,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                restaurants.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
