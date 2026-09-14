import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../utils/app_theme.dart';
import '../widgets/cart_badge.dart';
import '../widgets/footer_dialogs.dart';
import '../widgets/product_card.dart';
import '../widgets/responsive_container.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Product> get _filteredProducts {
    return ProductData.products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          product.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchesSearch = product.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Product> get _dealProducts {
    return ProductData.products.where((p) => p.oldPrice > p.price).toList();
  }

  List<Product> get _bestSellers {
    return ProductData.products.where((p) => p.rating >= 4.6).toList();
  }

  List<Product> get _recommended {
    return ProductData.products.where((p) => p.reviewCount >= 200).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToProducts() {
    _scrollController.animateTo(
      650,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _filterDeals() {
    setState(() {
      _selectedCategory = 'All';
      _searchQuery = '';
      _searchController.clear();
    });
    _scrollController.animateTo(
      1400,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 850;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: InkWell(
          onTap: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'ShopEase',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                    fontSize: 24,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'Shop Smart. Live Better.',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          if (isDesktop) ...[
            _buildNavMenuItem('Home', isSelected: true, onTap: () {
              _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut);
            }),
            _buildNavMenuItem('Shop', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShopScreen()),
              );
            }),
            _buildNavMenuItem('Categories', onTap: _scrollToProducts),
            _buildNavMenuItem('Deals', onTap: _filterDeals),
            const SizedBox(width: 16),
          ],
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded, size: 24),
            tooltip: 'Wishlist / Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
          const CartBadge(),
          IconButton(
            icon: const Icon(Icons.person_outline_rounded, size: 24),
            tooltip: 'My Account Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Banner Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isDesktop ? 36 : 22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.primaryLight,
                          Color(0xFF2563EB),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          children: [
                            // Text Content
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.22),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      '✨ PREMIUM SELECTIONS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    'Everything You Need.\nOne Smart Store.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isDesktop ? 34 : 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.15,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Discover products you\'ll love, at prices you\'ll love even more.',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: isDesktop ? 15 : 13,
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 10,
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: AppTheme.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22, vertical: 14),
                                        ),
                                        icon: const Icon(
                                            Icons.shopping_bag_outlined),
                                        label: const Text('SHOP NOW'),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ShopScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(
                                              color: Colors.white, width: 1.8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22, vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: _filterDeals,
                                        child: const Text('EXPLORE DEALS'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Hero Graphic Container (Desktop Display)
                            if (isDesktop)
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.shopping_cart_checkout_rounded,
                                      size: 110,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Category Cards Section ("Shop by Category")
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shop by Category',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Browse products tailored for your needs',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Category Cards Row
                      Row(
                        children: [
                          _buildCategoryCard(
                            context,
                            title: 'Electronics',
                            icon: Icons.devices_other_rounded,
                            gradient: const [Color(0xFF6366F1), Color(0xFF4F46E5)],
                            count: '6 Items',
                          ),
                          const SizedBox(width: 12),
                          _buildCategoryCard(
                            context,
                            title: 'Fashion',
                            icon: Icons.checkroom_rounded,
                            gradient: const [Color(0xFFEC4899), Color(0xFFDB2777)],
                            count: '2 Items',
                          ),
                          const SizedBox(width: 12),
                          _buildCategoryCard(
                            context,
                            title: 'Accessories',
                            icon: Icons.watch_outlined,
                            gradient: const [Color(0xFF06B6D4), Color(0xFF0284C7)],
                            count: '2 Items',
                          ),
                          const SizedBox(width: 12),
                          _buildCategoryCard(
                            context,
                            title: 'Home & Living',
                            icon: Icons.lightbulb_outline_rounded,
                            gradient: const [Color(0xFFF59E0B), Color(0xFFD97706)],
                            count: '1 Item',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Search Bar & Filter Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Search TextField
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
                      const SizedBox(height: 16),

                      // Horizontal Filter Chips
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: ProductData.categories.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final category = ProductData.categories[index];
                            final isSelected = _selectedCategory == category;
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
                      const SizedBox(height: 24),

                      // Section Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Trending Products',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Handpicked selections just for you',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopScreen(
                                      initialCategory: _selectedCategory),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Text('View All',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_rounded, size: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Trending Products Responsive Grid
              _filteredProducts.isEmpty
                  ? SliverToBoxAdapter(
                      child: Container(
                        height: 250,
                        alignment: Alignment.center,
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
                              'No products found matching your search',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextButton.icon(
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Clear Search & Filters'),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                  _selectedCategory = 'All';
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverLayoutBuilder(
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
                                  product: _filteredProducts[index],
                                );
                              },
                              childCount: _filteredProducts.length,
                            ),
                          );
                        },
                      ),
                    ),

              // Promotional Weekend Special Banner
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF06B6D4), Color(0xFF0284C7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'WEEKEND SPECIAL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Save Extra 5% At Checkout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Free delivery & promo code automatically applied on all orders today.',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),
                              const SizedBox(height: 14),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF0284C7),
                                ),
                                onPressed: _filterDeals,
                                child: const Text('SHOP DEALS'),
                              ),
                            ],
                          ),
                        ),
                        if (isDesktop)
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.local_offer_rounded,
                                size: 80, color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Today's Deals Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '🔥 Today\'s Deals',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Top discounted items with limited-time promotional pricing',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Deals Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverLayoutBuilder(
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
                            product: _dealProducts[index],
                          );
                        },
                        childCount: _dealProducts.length,
                      ),
                    );
                  },
                ),
              ),

              // Best Sellers Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '⭐ Best Sellers',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Highest customer rated products on ShopEase',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Best Sellers Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverLayoutBuilder(
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
                            product: _bestSellers[index],
                          );
                        },
                        childCount: _bestSellers.length,
                      ),
                    );
                  },
                ),
              ),

              // Recommended For You Section Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '💡 Recommended For You',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Popular picks based on customer reviews',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Recommended Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverLayoutBuilder(
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
                            product: _recommended[index],
                          );
                        },
                        childCount: _recommended.length,
                      ),
                    );
                  },
                ),
              ),

              // Interactive Footer Section
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.all(32),
                  color: AppTheme.textPrimary,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scrollController.animateTo(0,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeOut);
                                  },
                                  child: const Text(
                                    'ShopEase',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Shop Smart. Live Better.',
                                  style: TextStyle(
                                    color: Color(0xFF94A3B8),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isDesktop) ...[
                            Expanded(
                              child: _buildFooterColumn(context, 'Shop', [
                                FooterLink('All Products', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ShopScreen()));
                                }),
                                FooterLink('Electronics', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ShopScreen(
                                                  initialCategory:
                                                      'Electronics')));
                                }),
                                FooterLink('Fashion', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ShopScreen(
                                                  initialCategory:
                                                      'Fashion')));
                                }),
                                FooterLink('Accessories', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ShopScreen(
                                                  initialCategory:
                                                      'Accessories')));
                                }),
                                FooterLink('Home & Living', () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ShopScreen(
                                                  initialCategory:
                                                      'Home & Living')));
                                }),
                              ]),
                            ),
                            Expanded(
                              child: _buildFooterColumn(context, 'Customer Support', [
                                FooterLink('Contact Us', () {
                                  FooterDialogs.showContactDialog(context);
                                }),
                                FooterLink('Help Center', () {
                                  FooterDialogs.showHelpDialog(context);
                                }),
                                FooterLink('Shipping Policy', () {
                                  FooterDialogs.showShippingDialog(context);
                                }),
                              ]),
                            ),
                            Expanded(
                              child: _buildFooterColumn(context, 'Company', [
                                FooterLink('About Us', () {
                                  FooterDialogs.showAboutDialog(context);
                                }),
                                FooterLink('Privacy Policy', () {
                                  FooterDialogs.showPrivacyDialog(context);
                                }),
                                FooterLink('Terms of Service', () {
                                  FooterDialogs.showTermsDialog(context);
                                }),
                              ]),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: Color(0xFF334155)),
                      const SizedBox(height: 16),
                      const Text(
                        '© 2026 ShopEase. All rights reserved. University Mini Project.',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required String count,
  }) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedCategory = title;
            });
            _scrollToProducts();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  count,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavMenuItem(String title,
      {bool isSelected = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterColumn(
      BuildContext context, String title, List<FooterLink> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: InkWell(
              onTap: link.onTap,
              child: Text(
                link.title,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FooterLink {
  final String title;
  final VoidCallback onTap;

  FooterLink(this.title, this.onTap);
}
