class AuthService {
  // Static dummy login
  static Future<String?> login(String username, String password) async {
    // Example static credentials
    if (username == "admin" && password == "admin123") {
      return "admin"; // Admin role
    } else if (username == "user" && password == "user123") {
      return "user"; // User role
    } else {
      return null; // Invalid
    }
  }
}
