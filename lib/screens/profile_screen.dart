import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../providers/cart_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/responsive_container.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final favCount = ProductData.products.where((p) => p.isFavorite).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // User Header Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.12),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 44,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'john.doe@example.com',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '+91 98765 43210',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit Profile',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile edit mode activated (Demo Mode)'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Stats Counter Bar
              Row(
                children: [
                  Expanded(
                    child: _buildStatTile(
                      context,
                      title: 'Cart Items',
                      value: '${cart.itemCount}',
                      icon: Icons.shopping_cart_outlined,
                      color: AppTheme.primaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatTile(
                      context,
                      title: 'Wishlist',
                      value: '$favCount',
                      icon: Icons.favorite_outline_rounded,
                      color: AppTheme.errorColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatTile(
                      context,
                      title: 'Orders',
                      value: '1',
                      icon: Icons.local_shipping_outlined,
                      color: AppTheme.successColor,
                      onTap: () {
                        _showOrdersDialog(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Account Options List
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.receipt_long_outlined,
                          color: AppTheme.primaryColor),
                      title: const Text('My Recent Orders'),
                      subtitle: const Text('Track active orders & history'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => _showOrdersDialog(context),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.favorite_border_rounded,
                          color: AppTheme.errorColor),
                      title: const Text('My Wishlist'),
                      subtitle: Text('$favCount saved items'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.location_on_outlined,
                          color: AppTheme.secondaryColor),
                      title: const Text('Shipping Address'),
                      subtitle: const Text('123 Main Street, Mumbai - 400001'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Saved Address'),
                            content: const Text(
                              'John Doe\n123 Main Street, Area 4\nMumbai, Maharashtra - 400001\nPhone: +91 98765 43210',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.help_outline_rounded,
                          color: AppTheme.accentColor),
                      title: const Text('Customer Help & Support'),
                      subtitle: const Text('FAQs, email & phone support'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Help & Support'),
                            content: const Text(
                              'Need help with your order?\n\nEmail: support@shopease.demo\nPhone: +91 98765 43210\nHours: Mon - Sat (9 AM - 7 PM)',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: AppTheme.errorColor),
                    foregroundColor: AppTheme.errorColor,
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout (Demo Session)'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logged out of demo profile session'),
                        duration: Duration(seconds: 2),
                      ),
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

  Widget _buildStatTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOrdersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recent Orders'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_outline, color: AppTheme.successColor),
              title: Text('Order #SE40822'),
              subtitle: Text('Delivered • 1 Item • ₹2,374'),
            ),
            Divider(height: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.local_shipping_outlined, color: AppTheme.primaryColor),
              title: Text('Order #SE10245'),
              subtitle: Text('In Transit (3-5 Days) • 2 Items • ₹4,198'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
