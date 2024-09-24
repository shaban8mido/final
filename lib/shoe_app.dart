import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure you have the Firebase options imported
import 'auth_service.dart';
import 'login_page.dart'; // Import your login page
import 'shoe_store_page.dart'; // Import shoe store page
import 'cart_page.dart'; // Import cart page
import 'shoe_item.dart'; // Import shoe item model
import 'shoe_tile.dart'; // Import shoe tile

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      initialRoute: '/', // Set the initial route to login page
      routes: {
        '/': (context) => LoginPage(), // Route to LoginPage
        '/shoeApp': (context) => const ShoeApp(), // Route to ShoeApp
      },
    );
  }
}

class ShoeApp extends StatefulWidget {
  const ShoeApp({super.key});

  @override
  _ShoeAppState createState() => _ShoeAppState();
}

class _ShoeAppState extends State<ShoeApp> {
  final List<ShoeItem> shoes = [
    ShoeItem(name: 'Nike Air Max', price: 100.0, selectedSize: 7, imageUrl: 'https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/9f684ace-3163-4227-8f85-2d2a067dd4f5/AIR+MAX+90+GTX.png'),
    ShoeItem(name: 'Adidas Superstar', price: 120.0, selectedSize: 7, imageUrl: 'https://i8.amplience.net/i/jpl/jd_347113_b?v=1'),
    ShoeItem(name: 'Puma RS-X', price: 90.0, selectedSize: 7, imageUrl: 'data:image/jpeg;base64,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'),
    ShoeItem(name: 'Skechers', price: 80.0, selectedSize: 7, imageUrl: 'https://target.scene7.com/is/image/Target/GUEST_3eece230-8ed1-48fc-9c57-ffd73eb7b002?wid=488&hei=488&fmt=pjpeg'),
    ShoeItem(name: 'New Balance', price: 110.0, selectedSize: 7, imageUrl: 'https://nb.scene7.com/is/image/NB/bb2wycg3_nb_02_i?&wid=440&hei=440'),
    ShoeItem(name: 'Converse', price: 85.0, selectedSize: 7, imageUrl: 'https://cdn.laredoute.com/cdn-cgi/image/width=500,height=500,fit=pad,dpr=1/products/0/8/a/08a28fd5f69ae92b5a7694f1cfbda8ce.jpg'),
    ShoeItem(name: 'Air Jordans', price: 150.0, selectedSize: 7, imageUrl: 'https://i.ebayimg.com/images/g/TpkAAOSwkDZh-ZSV/s-l500.jpg'),
    ShoeItem(name: 'Gucci Shoes', price: 300.0, selectedSize: 7, imageUrl: 'https://cdn.saksfifthavenue.com/is/image/saks/0400014973000_BORDEAUX?wid=600&hei=800&qlt=90&resMode=sharp2&op_usm=0.9%2C1.0%2C8%2C0'),
    ShoeItem(name: 'Adidas Football Boots', price: 130.0, selectedSize: 7, imageUrl: 'https://sportfirstherveybay.com.au/cdn/shop/products/adidas-predator-accuracy-1-low-fg-football-boots-sportfirst-hervey-bay-1-22514086740023_grande.webp?v=1695296204'),
  ];

  List<ShoeItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          if (index == 0) {
            // Shoe Store Page
            return ShoeStorePage(
              shoes: shoes,
              onAddToCart: (ShoeItem shoe) {
                setState(() {
                  cartItems.add(shoe);
                });
              },
            );
          } else {
            // Cart Page
            return CartPage(
              cartItems: cartItems,
              onRemoveFromCart: (ShoeItem shoe) {
                setState(() {
                  cartItems.remove(shoe); // Remove the item from the cart
                });
              },
            );
          }
        },
      ),
    );
  }
}
