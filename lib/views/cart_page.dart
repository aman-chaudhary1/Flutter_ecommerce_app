import 'package:ecommerce_app/containers/cart_container.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        scrolledUnderElevation: 0,
        forceMaterialTransparency: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (value.carts.isEmpty) {
              return const Center(child: Text("No items in cart"));
            } else {
              if (value.products.isNotEmpty) {
                return ListView.builder(
                    itemCount: value.carts.length,
                    itemBuilder: (context, index) {
                      print("selected ${value.carts[index].quantity}");
                      return CartContainer(
                          image: value.products[index].image,
                          name: value.products[index].name,
                          new_price: value.products[index].new_price,
                          old_price: value.products[index].old_price,
                          maxQuantity: value.products[index].maxQuantity,
                          selectedQuantity: value.carts[index].quantity,
                          productId: value.products[index].id);
                    });
              } else {
                return const Text("No items in cart");
              }
            }
          }
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.carts.isEmpty) {
            return const SizedBox();
          } else {
            return Container(
               width: double.infinity,
          height: 60,
          padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total : ₹${value.totalCost} ",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context,"/checkout");
                  },
                    style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ), child: const Text("Procced to Checkout"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
