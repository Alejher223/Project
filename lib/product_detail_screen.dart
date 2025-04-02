import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'cart_model.dart'; // Import the CartItem model
import 'cart_data.dart'; // Import the global cart list
import 'checkout_screen.dart'; // Import the CheckoutScreen

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;
  final String productDescription;

  const ProductDetailScreen({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedIndex = 0;

  // Function to handle Add to Cart action
  void _addToCart() {
    setState(() {
      // Add the product to the global cartItems list
      cartItems.add(CartItem(
        name: widget.productName,
        price: widget.productPrice,
        image: widget.productImage, // Pass the image as well
      ));
    });

    // Show a snackbar notification after adding to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.productName} added to cart'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Function to handle Bottom Navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image (Smaller size)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.productImage,
                height: 200, // Reduced the image height
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              widget.productName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Product Price
            Text(
              widget.productPrice,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),

            // Product Description
            Text(
              widget.productDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // Buttons
            ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Proceed to Checkout Button (Now goes to CheckoutScreen)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CheckoutScreen()), // Change to CheckoutScreen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff587ed5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(200, 50),
              ),
              child: const Text(
                'Check Out',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
