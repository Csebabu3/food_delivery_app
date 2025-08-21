import 'package:flutter/material.dart';
import 'package:food_delivery/screens/AnalyticsPage.dart';
import 'package:food_delivery/screens/MenuManagementPage.dart';
import 'package:food_delivery/screens/NotificationsPage.dart';
import 'package:food_delivery/screens/OrderManagementPage.dart';
import 'package:food_delivery/screens/RatingsPage.dart';
import 'package:food_delivery/screens/RestaurantManagementPage.dart';
import 'package:food_delivery/screens/browse_restaurants_page.dart';
import 'package:food_delivery/screens/cartCheckout.dart';
import 'package:food_delivery/services/notification_service.dart';
import 'package:food_delivery/screens/orderTrackingPage.dart';
import 'package:food_delivery/screens/paymentIntegrationPage.dart';
import 'package:food_delivery/screens/profile_page.dart';
import 'package:food_delivery/screens/search_filter_page.dart';

class AppDrawer extends StatelessWidget {
  final String role; // 'Admin' or 'User'

  const AppDrawer({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(role),
            accountEmail: Text("$role@example.com"),
            currentAccountPicture: CircleAvatar(
              child: Text(
                role[0], // First letter (A or U)
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          if (role == "Admin") ...[
            ListTile(
              leading: Icon(Icons.store, color: Colors.blue), // Restaurant icon
              title: Text("Manage Restaurants"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantManagementPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.fastfood,
                color: Colors.green,
              ), // Food/Menu icon
              title: Text("Menu Management"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuManagementPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.receipt_long,
                color: Colors.orange,
              ), // Orders icon
              title: Text("Manage Orders"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderManagementPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.analytics,
                color: Colors.purple,
              ), // Analytics icon
              title: Text("Analytics"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalyticsPage()),
                );
              },
            ),
          ] else ...[
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text("Profile Management"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.restaurant_menu, color: Colors.green),
              title: Text("Browse Restaurant and Menu"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrowseRestaurantsPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.search, color: Colors.orange),
              title: Text("Search & Filters"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchFilterPage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.purple),
              title: Text("Cart & Checkout"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartCheckoutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.teal),
              title: Text("Payment Integration"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentIntegrationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delivery_dining, color: Colors.red),
              title: Text("Order Tracking"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderTrackingPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star_rate, color: Colors.amber),
              title: Text("Ratings & Reviews"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RatingsPage(
                      restaurantName: "Foodie's Hub",
                      foodItems: ["Pizza", "Burger", "Pasta"],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.indigo),
              title: Text("Notifications"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),
          ],
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
