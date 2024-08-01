import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://16.171.150.101/quick-campus/backend";

  // Register users
  Future<Map<String, dynamic>> register(
      String firstname,
      String lastname,
      String email,
      String password,
      String confirmPassword,
      int role,
      String phoneNumber) async {
    final response = await http.post(Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'confirm_password': password,
          'role': role,
          "phone_number": phoneNumber
        }));

    print(response.body);

    if (response.statusCode == 500 || response.statusCode == 503) {
      throw Exception("Server error");
    } else {
      return jsonDecode(response.body);
    }
  }

  // Log users into the application
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}));
    print("The login response is: ${response.body}");
    if (response.statusCode == 500 || response.statusCode == 503) {
      throw Exception("Server error");
    } else {
      return jsonDecode(response.body);
    }
  }

  // Get the profile details of a user
  Future<Map<String, dynamic>> getProfile(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get profile");
    }
  }

  // Log in with firebase
  ///Let user sign in with email and password
}
