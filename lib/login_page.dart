import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart'; // Import your AuthService
import 'signup_page.dart'; // Import the Sign Up page
import 'reset_password_page.dart'; // Import the Reset Password page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    // Use your AuthService for login
    final user = await AuthService().signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
    if (user != null) {
      // Navigate to the shoe app
      Navigator.pushReplacementNamed(context, '/shoeApp');
    } else {
      // Handle login failure (show a message)
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'), // Your logo image
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _emailController,
                placeholder: 'Email',
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 12),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: 'Password',
                obscureText: true,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: CupertinoColors.systemGrey),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                child: Text('Login'),
                onPressed: _login,
              ),
              SizedBox(height: 12),
              CupertinoButton(
                child: Text('Sign Up'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => SignUpPage()),
                  );
                },
              ),
              SizedBox(height: 12),
              CupertinoButton(
                child: Text('Reset Password'),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => ResetPasswordPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
