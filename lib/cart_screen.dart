import 'package:flutter/material.dart';
import 'cart_data.dart'; // Import the global cart list
// Import CartItem model
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to calculate total price in pesos
  double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      // Clean the price string to remove non-numeric characters (except the decimal point)
      String cleanedPrice = item.price.replaceAll(RegExp(r'[^\d.]'), '');
      double itemPrice = double.tryParse(cleanedPrice) ?? 0.0;
      total += itemPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            cartItems[index].image, // Display product image
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          cartItems[index].name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'Price: ₱${cartItems[index].price}', // Display price with peso sign
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              cartItems.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                // Total Price
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '₱${getTotalPrice().toStringAsFixed(2)}', // Display total with peso sign
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Proceed to Checkout Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Checkout Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff587ed5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Proceed to Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
