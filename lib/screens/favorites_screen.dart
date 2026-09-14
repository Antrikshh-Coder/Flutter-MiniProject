import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../utils/app_theme.dart';
import '../widgets/cart_badge.dart';
import '../widgets/product_card.dart';
import '../widgets/responsive_container.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Product> get _favoriteProducts {
    return ProductData.products.where((p) => p.isFavorite).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites (${favorites.length})'),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              tooltip: 'Clear Favorites',
              onPressed: () {
                setState(() {
                  for (var p in ProductData.products) {
                    p.isFavorite = false;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cleared all items from favorites'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          const CartBadge(),
          const SizedBox(width: 8),
        ],
      ),
      body: ResponsiveContainer(
        maxWidth: 1100,
        child: favorites.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 80,
                          color: AppTheme.errorColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'No Favorites Saved Yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap the heart icon on any product card to add it to your wishlist.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text('Explore Products'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Your Saved Wishlist',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              '${favorites.length} Items Saved',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final width = MediaQuery.of(context).size.width;
                        int crossAxisCount = 2;
                        if (width >= 1050) {
                          crossAxisCount = 4;
                        } else if (width >= 680) {
                          crossAxisCount = 3;
                        }

                        return SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ProductCard(
                                product: favorites[index],
                              );
                            },
                            childCount: favorites.length,
                          ),
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
