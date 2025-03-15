import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'task_list_screen.dart';
import 'registration_screen.dart';  // Import the registration screen
 
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  @override
  void initState() {
    super.initState();
    checkIfUserLoggedIn();
  }
 
  // Check if the user is already logged in
  Future<void> checkIfUserLoggedIn() async {
    var user = await ParseUser.currentUser();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/taskPage'); // Redirect to Task List screen
    }
  }
 
  // Login the user
  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
 
    if (email.isEmpty || password.isEmpty) {
      _showError("Please enter email and password");
      return;
    }
 
    final user = ParseUser(email, password, null);
    final response = await user.login();
 
    if (response.success) {
      Navigator.pushReplacementNamed(context, '/taskPage'); // Use Named Routes for navigation
    } else {
      _showError(response.error?.message ?? "Login failed");
    }
  }
 
  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
 
  // Navigate to Registration Screen
  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _goToRegister,
              child: Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}