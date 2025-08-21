import 'package:flutter/material.dart';

class MenuManagementPage extends StatefulWidget {
  @override
  _MenuManagementPageState createState() => _MenuManagementPageState();
}

class _MenuManagementPageState extends State<MenuManagementPage> {
  List<Map<String, dynamic>> menuItems = [
    {
      "name": "Margherita Pizza",
      "category": "Pizza",
      "price": 250,
      "rating": 4.6,
      "image": "assets/images/pizza.png",
    },
    {
      "name": "Cheese Burger",
      "category": "Burger",
      "price": 180,
      "rating": 4.3,
      "image": "assets/images/burger.png",
    },
  ];

  final _formKey = GlobalKey<FormState>();
  String name = "";
  String category = "";
  double price = 0;
  double rating = 0;

  void _showMenuDialog({Map<String, dynamic>? item, int? index}) {
    if (item != null) {
      name = item["name"];
      category = item["category"];
      price = item["price"];
      rating = item["rating"];
    } else {
      name = "";
      category = "";
      price = 0;
      rating = 0;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item == null ? "Add Menu Item" : "Edit Menu Item"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: name,
                    decoration: InputDecoration(labelText: "Item Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter item name" : null,
                    onChanged: (val) => name = val,
                  ),
                  TextFormField(
                    initialValue: category,
                    decoration: InputDecoration(labelText: "Category"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter category" : null,
                    onChanged: (val) => category = val,
                  ),
                  TextFormField(
                    initialValue: price.toString(),
                    decoration: InputDecoration(labelText: "Price"),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? "Enter price" : null,
                    onChanged: (val) => price = double.tryParse(val) ?? 0,
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
              child: Text(item == null ? "Add" : "Update"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    if (item == null) {
                      menuItems.add({
                        "name": name,
                        "category": category,
                        "price": price,
                        "rating": rating,
                        "image": "assets/images/food.png",
                      });
                    } else {
                      menuItems[index!] = {
                        "name": name,
                        "category": category,
                        "price": price,
                        "rating": rating,
                        "image": item["image"],
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
        title: Text("Menu Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add Menu Item",
            onPressed: () => _showMenuDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: menuItems.isEmpty
            ? Center(child: Text("No menu items added yet"))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 3 : 1,
                  childAspectRatio: isWide ? 3 : 3.5,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item["image"],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item["name"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${item["category"]} • ⭐ ${item["rating"]} • ₹${item["price"]}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () =>
                                _showMenuDialog(item: item, index: index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                menuItems.removeAt(index);
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
