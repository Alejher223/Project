import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';

class StrengthTrainingScreen extends StatefulWidget {
  const StrengthTrainingScreen({super.key});

  @override
  _StrengthTrainingScreenState createState() => _StrengthTrainingScreenState();
}

class _StrengthTrainingScreenState extends State<StrengthTrainingScreen> {
  final List<Map<String, String>> products = [
    {
      'name': 'Shoulder Machine',
      'price': '₱129,000.00 PHP',
      'image': 'assets/images/sp2.jpg',
      'description':
          'A premium shoulder training machine for serious bodybuilders.',
    },
    {
      'name': 'Lat Pull Machine',
      'price': '₱25,000.00 PHP',
      'image': 'assets/images/latpulldown.jpg',
      'description': 'Ideal for targeting the back and improving lat strength.',
    },
    {
      'name': 'Dumbbell',
      'price': '₱700.00 PHP',
      'image': 'assets/images/dumbbell.jpg',
      'description': 'A versatile weight for all strength training exercises.',
    },
    {
      'name': 'Barbell',
      'price': '₱5,000.00 PHP',
      'image': 'assets/images/barbell.jpg',
      'description': 'Great for heavy lifts like bench press and deadlifts.',
    },
  ];

  final List<Map<String, String>> favorites = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CartScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FavoriteScreen(favorites: favorites)),
      );
    }
  }

  void _toggleFavorite(Map<String, String> product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered Fitness Gear Hub Text
            Center(
              child: Text(
                'Fitness Gear Hub',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,  
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
                height: 10), // Add some spacing between the two texts

            // Strength Training Text
            const Center(
              child: Text(
                'Strength Training',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20),

            // GridView of Products
            GridView.builder(
              shrinkWrap:
                  true, // Allow GridView to take only the space it needs
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final isFavorite = favorites.contains(product);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productName: product['name']!,
                          productPrice: product['price']!,
                          productImage: product['image']!,
                          productDescription: product['description']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Product Image
                        Image.asset(
                          product['image']!,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),

                        // Product Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            product['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Product Price with Heart Icon aligned to the right of the 'P' in PHP
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product['price']!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              GestureDetector(
                                onTap: () => _toggleFavorite(product),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                  size: 15, // Smaller size for the icon
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.black,
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
