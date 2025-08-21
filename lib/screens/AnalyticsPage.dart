import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "id": "ORD001",
      "customer": "John Doe",
      "items": ["Pizza", "Coke"],
      "total": 500,
    },
    {
      "id": "ORD002",
      "customer": "Alice Smith",
      "items": ["Burger", "Fries"],
      "total": 300,
    },
    {
      "id": "ORD003",
      "customer": "Robert Brown",
      "items": ["Pizza", "Juice"],
      "total": 450,
    },
    {
      "id": "ORD004",
      "customer": "David Miller",
      "items": ["Burger", "Coke"],
      "total": 250,
    },
  ];

  int getTotalOrders() => orders.length;

  int getTotalRevenue() =>
      orders.fold(0, (sum, order) => sum + (order["total"] as int));

  String getMostPopularItem() {
    Map<String, int> itemCount = {};
    for (var order in orders) {
      for (var item in order["items"]) {
        itemCount[item] = (itemCount[item] ?? 0) + 1;
      }
    }

    String popularItem = "";
    int maxCount = 0;
    itemCount.forEach((item, count) {
      if (count > maxCount) {
        maxCount = count;
        popularItem = item;
      }
    });

    return popularItem.isEmpty ? "N/A" : "$popularItem ($maxCount orders)";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWide = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(title: Text("Analytics"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: isWide ? 3 : 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildAnalyticsCard(
              title: "Total Orders",
              value: getTotalOrders().toString(),
              color: Colors.blue,
              icon: Icons.shopping_bag,
            ),
            _buildAnalyticsCard(
              title: "Total Revenue",
              value: "₹${getTotalRevenue()}",
              color: Colors.green,
              icon: Icons.attach_money,
            ),
            _buildAnalyticsCard(
              title: "Popular Item",
              value: getMostPopularItem(),
              color: Colors.orange,
              icon: Icons.star,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
