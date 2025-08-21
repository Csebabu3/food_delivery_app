import 'package:flutter/material.dart';

class OrderManagementPage extends StatefulWidget {
  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "customer": "John Doe",
      "items": ["Pizza", "Coke"],
      "total": 500,
      "status": "Pending",
    },
    {
      "id": "ORD002",
      "customer": "Alice Smith",
      "items": ["Burger", "Fries"],
      "total": 300,
      "status": "Preparing",
    },
    {
      "id": "ORD003",
      "customer": "Robert Brown",
      "items": ["Pasta", "Juice"],
      "total": 450,
      "status": "Out for Delivery",
    },
  ];

  final List<String> statusOptions = [
    "Pending",
    "Preparing",
    "Out for Delivery",
    "Delivered",
  ];

  void _updateOrderStatus(int index, String newStatus) {
    setState(() {
      orders[index]["status"] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWide = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: Text("Order Management"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: orders.isEmpty
            ? Center(child: Text("No orders available"))
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order ID and Customer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order #${order["id"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "₹${order["total"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text("Customer: ${order["customer"]}"),
                          SizedBox(height: 6),

                          // Items
                          Text(
                            "Items: ${order["items"].join(", ")}",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 10),

                          // Status dropdown
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              DropdownButton<String>(
                                value: order["status"],
                                items: statusOptions.map((status) {
                                  return DropdownMenuItem<String>(
                                    value: status,
                                    child: Text(status),
                                  );
                                }).toList(),
                                onChanged: (newStatus) {
                                  _updateOrderStatus(index, newStatus!);
                                },
                              ),
                            ],
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
