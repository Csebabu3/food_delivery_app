import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class UserDashboard extends StatelessWidget {
  final String userName = "John Doe";
  final String userEmail = "johndoe@email.com";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Dashboard"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
      ),
      drawer: AppDrawer(role: "User"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),

                title: Text(
                  userName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(userEmail),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Navigate to profile edit page
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 600;
                return GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: isWide ? 4 : 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildActionCard(
                      Icons.shopping_bag,
                      "My Orders",
                      Colors.blue,
                      () {},
                    ),
                    _buildActionCard(
                      Icons.favorite,
                      "Wishlist",
                      Colors.red,
                      () {},
                    ),
                    _buildActionCard(
                      Icons.notifications,
                      "Notifications",
                      Colors.orange,
                      () {},
                    ),
                    _buildActionCard(
                      Icons.settings,
                      "Settings",
                      Colors.green,
                      () {},
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),

            // Recent Orders
            Text(
              "Recent Orders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildOrderCard("Order #1001", "Delivered", "₹450"),
            _buildOrderCard("Order #1002", "Pending", "₹299"),
            _buildOrderCard("Order #1003", "Cancelled", "₹120"),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(String orderId, String status, String amount) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(Icons.receipt_long, color: Colors.blue),
        title: Text(orderId),
        subtitle: Text("Status: $status"),
        trailing: Text(
          amount,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }
}
