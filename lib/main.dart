import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core for initialization
import 'login_page.dart';
import 'shoe_app.dart'; // Your shoe app entry point
import 'signup_page.dart'; // Import the Sign Up page
import 'reset_password_page.dart'; // Import the Reset Password page
import 'firebase_options.dart'; // Import your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Store App',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/shoeApp': (context) => const ShoeApp(), // Your shoe app main page
        '/signup': (context) => SignUpPage(), // Route for Sign Up page
        '/resetPassword': (context) => ResetPasswordPage(), // Route for Reset Password page
      },
    );
  }
}
