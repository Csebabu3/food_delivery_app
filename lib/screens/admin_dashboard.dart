import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        centerTitle: true,
        elevation: 2,
      ),
      drawer: AppDrawer(role: "Admin"),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 700;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Welcome Section
                Row(
                  children: [
                    CircleAvatar(
                      radius: isWide ? 50 : 35,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome, Admin!",
                            style: TextStyle(
                              fontSize: isWide ? 24 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Manage your app efficiently",
                            style: TextStyle(
                              fontSize: isWide ? 18 : 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),

                // Quick Action Cards
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: isWide ? 20 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 4 : 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildActionTile(
                      Icons.shopping_bag,
                      "Manage Orders",
                      Colors.blue,
                      () {},
                    ),
                    _buildActionTile(
                      Icons.people,
                      "Manage Users",
                      Colors.red,
                      () {},
                    ),
                    _buildActionTile(
                      Icons.analytics,
                      "Analytics",
                      Colors.orange,
                      () {},
                    ),
                    _buildActionTile(
                      Icons.settings,
                      "Settings",
                      Colors.green,
                      () {},
                    ),
                    _buildActionTile(
                      Icons.star,
                      "Reviews",
                      Colors.purple,
                      () {},
                    ),
                    _buildActionTile(
                      Icons.notifications,
                      "Notifications",
                      Colors.teal,
                      () {},
                    ),
                  ],
                ),
                SizedBox(height: 25),

                // Recent Orders / Reports
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontSize: isWide ? 20 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                _buildOrderCard(
                  "Order #1001",
                  "Delivered",
                  "₹450",
                  Colors.green.shade600,
                  isWide,
                ),
                _buildOrderCard(
                  "Order #1002",
                  "Pending",
                  "₹299",
                  Colors.orange.shade600,
                  isWide,
                ),
                _buildOrderCard(
                  "Order #1003",
                  "Cancelled",
                  "₹120",
                  Colors.red.shade600,
                  isWide,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionTile(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
    String orderId,
    String status,
    String amount,
    Color statusColor,
    bool isWide,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.receipt_long, color: statusColor),
        ),
        title: Text(orderId),
        subtitle: Text("Status: $status", style: TextStyle(color: statusColor)),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isWide ? 16 : 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
