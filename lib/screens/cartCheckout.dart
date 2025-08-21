import 'package:flutter/material.dart';

class CartCheckoutPage extends StatefulWidget {
  @override
  _CartCheckoutPageState createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  // Sample items (could be fetched from API/DB)
  List<Map<String, dynamic>> cartItems = [
    {"name": "Pizza", "price": 120.0, "quantity": 1},
    {"name": "Burger", "price": 80.0, "quantity": 2},
    {"name": "Pasta", "price": 100.0, "quantity": 1},
  ];

  String? selectedDelivery = "Home Delivery";
  TextEditingController couponController = TextEditingController();
  double discount = 0;

  // Total price with discount applied
  double get totalPrice {
    double sum = cartItems.fold(
      0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
    return (sum - discount).clamp(0, double.infinity); // prevent negative total
  }

  // Apply coupon logic
  void applyCoupon() {
    FocusScope.of(context).unfocus(); // dismiss keyboard
    setState(() {
      if (couponController.text.trim().toUpperCase() == "FOOD10") {
        discount = 50; // Flat discount for demo
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Coupon applied: ₹50 OFF 🎉")));
      } else {
        discount = 0;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid coupon ❌")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenW = MediaQuery.of(context).size.width;
    bool isTablet = screenW > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart & Checkout"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Cart Items
            Expanded(
              child: cartItems.isEmpty
                  ? Center(
                      child: Text(
                        "Your cart is empty 🛒",
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Dismissible(
                          key: ValueKey(item['name']),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: Icon(
                                Icons.fastfood,
                                color: Colors.purple,
                                size: isTablet ? 35 : 25,
                              ),
                              title: Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: isTablet ? 20 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "₹${item['price'].toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: isTablet ? 18 : 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              trailing: Container(
                                width: isTablet ? 160 : 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (item['quantity'] > 1) {
                                            item['quantity']--;
                                          } else {
                                            cartItems.removeAt(index);
                                          }
                                        });
                                      },
                                    ),
                                    Text(
                                      "${item['quantity']}",
                                      style: TextStyle(
                                        fontSize: isTablet ? 20 : 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          item['quantity']++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Checkout Section
            if (cartItems.isNotEmpty)
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Option
                    Text(
                      "Delivery Option:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 18 : 14,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedDelivery,
                      isExpanded: true,
                      items: ["Home Delivery", "Pick Up"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedDelivery = val;
                        });
                      },
                    ),
                    SizedBox(height: 10),

                    // Coupon
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: couponController,
                            decoration: InputDecoration(
                              hintText: "Enter coupon code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: applyCoupon,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: Text("Apply"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Price Summary
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal:",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (discount > 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount:",
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "-₹$discount",
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Place Order
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 18 : 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.payment, color: Colors.white),
                        label: Text(
                          "Place Order",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 14,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Order placed successfully! 🎉"),
                            ),
                          );
                          setState(() {
                            cartItems.clear();
                            couponController.clear();
                            discount = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
