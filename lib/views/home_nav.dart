import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:ecommerce_app/views/cart_page.dart';
import 'package:ecommerce_app/views/home.dart';
import 'package:ecommerce_app/views/orders_page.dart';
import 'package:ecommerce_app/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  @override
  void initState() {
    Provider.of<UserProvider>(context,listen: false);
    super.initState();
  }

  int selectedIndex = 0;

  List pages = [
    const HomePage(),
    const OrdersPage(),
    const CartPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex=value;
          });
        },
        selectedItemColor:  Colors.blue,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_outlined),
              label: 'Orders',
            ),
          BottomNavigationBarItem(
              icon: Consumer<CartProvider>(
                builder: (context, value, child) {
                  if(value.carts.isNotEmpty){
                    return Badge(label: Text(value.carts.length.toString()),
                    backgroundColor:  Colors.green.shade400,
                    child: const Icon(Icons.shopping_cart_outlined),
                    );
                  }
                  return const Icon(Icons.shopping_cart_outlined);
                },
              ),
              label: 'Cart',
            ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
        ],
      ),
    );
  }
}

/*
This is the home navbar of the app
 */