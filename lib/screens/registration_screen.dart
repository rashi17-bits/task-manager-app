import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'login_screen.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
 
Future<void> registerUser(BuildContext context, String email, String password) async {
  final user = ParseUser(email, password, null);
  user.set("email", email); // Explicitly set the email field
 
  var response = await user.signUp();
 
  if (response.success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration successful! Redirecting to login...')),
    );
 
    // Logout the user after successful registration
    await user.logout();
 
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  } else {
    print('Registration failed: ${response.error?.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration failed: ${response.error?.message ?? 'Unknown error'}'))
    );
  }
}
 
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email TextField
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            // Register Button
            ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
 
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter email and password'))
                  );
                  return;
                }
 
                // Call the registerUser function and pass context
                registerUser(context, email, password);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}