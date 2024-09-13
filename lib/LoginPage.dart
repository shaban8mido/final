import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart'; // Import the AuthService

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo or Image at the top
            Image.asset(
              'assets/logo.png', // Path to your image
              height: 150, // Adjust the height based on your design
            ),
            const SizedBox(height: 20),

            // Email TextField with padding and border radius
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent, width: 1.5),
              ),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: InputBorder.none, // Removes the default border
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Password TextField with padding and border radius
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent, width: 1.5),
              ),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none, // Removes the default border
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                obscureText: true, // To hide the password
              ),
            ),
            const SizedBox(height: 20),
            
            // Login Button
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  // Show error if email or password is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter both email and password')),
                  );
                  return;
                }

                // Use AuthService to sign in with email and password
                try {
                  User? user = await _authService.signInWithEmailAndPassword(email, password);
                  if (user != null) {
                    // Login successful, navigate to the next screen or show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successful! Welcome, ${user.email}')),
                    );
                    // Navigate to the home screen or another page
                    Navigator.pushReplacementNamed(context, '/home'); 
                  } else {
                    // Login failed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login failed. Please try again.')),
                    );
                  }
                } catch (e) {
                  // Catch and show any error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              child: const Text('Login'),
            ),
            
            // Sign-Up Button
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('Sign Up'),
            ),
            
            // Forgot Password Button
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset-password');
              },
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
