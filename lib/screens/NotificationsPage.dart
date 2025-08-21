import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, String>> notifications = [
    {"title": "Order Confirmed", "body": "Your pizza order is confirmed!"},
    {"title": "Preparing Order", "body": "Your food is being prepared 🍳"},
    {"title": "Order Delivered", "body": "Enjoy your meal 🍔🍟"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
      ),
      body: notifications.isEmpty
          ? Center(child: Text("No notifications yet 🔔"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: isTablet ? 40 : 12,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.notifications, color: Colors.purple),
                    title: Text(
                      n["title"]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 16,
                      ),
                    ),
                    subtitle: Text(
                      n["body"]!,
                      style: TextStyle(fontSize: isTablet ? 16 : 14),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
