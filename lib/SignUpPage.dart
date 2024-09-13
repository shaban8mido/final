import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';  // Import the auth service

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  border: InputBorder.none,
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
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password TextField with padding and border radius
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent, width: 1.5),
              ),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                String confirmPassword = _confirmPasswordController.text.trim();

                if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                  // Show error if any field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                if (password != confirmPassword) {
                  // Show error if passwords do not match
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                // Use AuthService to sign up
                User? user = await _authService.signUpWithEmailAndPassword(email, password);

                if (user != null) {
                  // If sign up is successful, show success message and navigate back to LoginPage
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign-up successful! Please log in.')),
                  );
                  Navigator.pop(context); // Navigate back to LoginPage
                } else {
                  // Show error if sign-up failed
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign-up failed. Please try again.')),
                  );
                }
              },
              child: const Text('Sign Up'),
            ),

            // Already have an account? Navigate back to login page
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to LoginPage
              },
              child: const Text('Already have an account? Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
