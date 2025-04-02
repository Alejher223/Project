import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstScreen(), // Start with the first screen
  ));
}

// First Screen
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to FavoriteScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoriteScreen(
                  favorites: [
                    {
                      'name': 'Product 1',
                      'price': '\$10',
                      'image': 'assets/product1.png',
                    },
                    {
                      'name': 'Product 2',
                      'price': '\$15',
                      'image': 'assets/product2.png',
                    },
                  ],
                ),
              ),
            );
          },
          child: const Text('Go to Favorites'),
        ),
      ),
    );
  }
}

// Favorite Screen
class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> favorites;

  const FavoriteScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true, // Automatically adds a back button
      ),
      backgroundColor: Colors.black,
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return Card(
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      product['image']!,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                    title: Text(
                      product['name']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      product['price']!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
