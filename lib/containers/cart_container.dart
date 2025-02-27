import 'package:ecommerce_app/contants/discount.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartContainer extends StatefulWidget {
  final String image, name, productId;
  final int new_price, old_price, maxQuantity, selectedQuantity;
  const CartContainer(
      {super.key,
      required this.image,
      required this.name,
      required this.productId,
      required this.new_price,
      required this.old_price,
      required this.maxQuantity,
      required this.selectedQuantity});

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  int count = 1;

  increaseCount(int max) async {
    if (count >= max) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Maximum Quantity reached"),
      ));
      return;
    } else {
      Provider.of<CartProvider>(context, listen: false)
          .addToCart(CartModel(productId: widget.productId, quantity: count));
      setState(() {
        count++;
      });
    }
  }

 decreaseCount() async {
    if (count > 1) {
      Provider.of<CartProvider>(context, listen: false)
          .decreaseCount(widget.productId);
      setState(() {
        count--;
      });
    }
  }

  @override
  void initState() {
    count=widget.selectedQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 80, width: 80, child: Image.network(widget.image)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "₹${widget.old_price}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "₹${widget.new_price}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                            size: 20,
                          ),
                          Text(
                            "${discountPercent(widget.old_price, widget.new_price)}%",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      Provider.of<CartProvider>(context, listen: false)
                          .deleteItem(widget.productId);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade400,
                    ))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text(
                  "Quantity:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        increaseCount(widget.maxQuantity);
                      },
                      icon: const Icon(Icons.add)),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "$count",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        decreaseCount();
                       
                      },
                      icon: const Icon(Icons.remove)),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Spacer(),
                const Text("Total:"),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "₹${widget.new_price * count}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
