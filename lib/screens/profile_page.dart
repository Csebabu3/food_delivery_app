import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String name = "John Doe";
  String email = "john@example.com";
  String phone = "9876543210";
  String address = "123, Main Street, Chennai";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Management"),
        centerTitle: size.width < 600,
        elevation: 6,
        shadowColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isWide ? 600 : double.infinity,
            ),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      TextFormField(
                        initialValue: name,
                        decoration: const InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) => name = val ?? "",
                        validator: (val) =>
                            val!.isEmpty ? "Name cannot be empty" : null,
                      ),
                      const SizedBox(height: 15),

                      // Email Field
                      TextFormField(
                        initialValue: email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) => email = val ?? "",
                        validator: (val) =>
                            val!.contains("@") ? null : "Enter valid email",
                      ),
                      const SizedBox(height: 15),

                      // Phone Field
                      TextFormField(
                        initialValue: phone,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) => phone = val ?? "",
                        validator: (val) => val!.length == 10
                            ? null
                            : "Enter valid phone number",
                      ),
                      const SizedBox(height: 15),

                      // Address Field
                      TextFormField(
                        initialValue: address,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) => address = val ?? "",
                      ),
                      const SizedBox(height: 25),

                      // Save Button
                      ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text("Save Profile"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Profile Updated")),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
