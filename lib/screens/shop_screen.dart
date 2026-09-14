import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../utils/app_theme.dart';
import '../widgets/cart_badge.dart';
import '../widgets/product_card.dart';
import '../widgets/responsive_container.dart';

class ShopScreen extends StatefulWidget {
  final String initialCategory;

  const ShopScreen({
    super.key,
    this.initialCategory = 'All',
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late String _selectedCategory;
  String _searchQuery = '';
  String _sortOption = 'Featured';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filteredProducts {
    List<Product> list = ProductData.products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          product.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = product.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    if (_sortOption == 'Price: Low to High') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortOption == 'Price: High to Low') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortOption == 'Highest Rated') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Catalog'),
        actions: const [
          CartBadge(),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            children: [
              // Search & Sorting Control Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search products, categories...',
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppTheme.primaryColor,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Filter Chips & Sort Dropdown Row
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: ProductData.categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 6),
                              itemBuilder: (context, index) {
                                final category = ProductData.categories[index];
                                final isSelected =
                                    _selectedCategory == category;
                                return ChoiceChip(
                                  label: Text(category),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    if (selected) {
                                      setState(() {
                                        _selectedCategory = category;
                                      });
                                    }
                                  },
                                  selectedColor: AppTheme.primaryColor,
                                  backgroundColor: Colors.white,
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: isSelected
                                        ? Colors.white
                                        : AppTheme.textSecondary,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: isSelected
                                          ? AppTheme.primaryColor
                                          : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Sorting Popup Menu
                        PopupMenuButton<String>(
                          initialValue: _sortOption,
                          onSelected: (val) {
                            setState(() {
                              _sortOption = val;
                            });
                          },
                          icon: const Icon(Icons.sort_rounded,
                              color: AppTheme.primaryColor),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                                value: 'Featured', child: Text('Featured')),
                            const PopupMenuItem(
                                value: 'Price: Low to High',
                                child: Text('Price: Low to High')),
                            const PopupMenuItem(
                                value: 'Price: High to Low',
                                child: Text('Price: High to Low')),
                            const PopupMenuItem(
                                value: 'Highest Rated',
                                child: Text('Highest Rated')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Product Count Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Showing ${_filteredProducts.length} Results',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    if (_searchQuery.isNotEmpty || _selectedCategory != 'All')
                      TextButton.icon(
                        icon: const Icon(Icons.refresh_rounded, size: 16),
                        label: const Text('Reset Filters'),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                            _selectedCategory = 'All';
                            _sortOption = 'Featured';
                          });
                        },
                      ),
                  ],
                ),
              ),

              // Product Grid View
              Expanded(
                child: _filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: AppTheme.textLight,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No products found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Try adjusting your search query or reset category filter.',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _selectedCategory = 'All';
                                });
                              },
                              child: const Text('Clear Search & Filters'),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final width = MediaQuery.of(context).size.width;
                          int crossAxisCount = 2;
                          if (width >= 1050) {
                            crossAxisCount = 4;
                          } else if (width >= 680) {
                            crossAxisCount = 3;
                          }

                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: _filteredProducts[index],
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
