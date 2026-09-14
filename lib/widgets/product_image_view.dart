import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/app_theme.dart';

class ProductImageView extends StatelessWidget {
  final Product product;
  final double height;
  final double width;
  final BoxFit fit;

  const ProductImageView({
    super.key,
    required this.product,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices_other_rounded;
      case 'Fashion':
        return Icons.checkroom_rounded;
      case 'Accessories':
        return Icons.watch_outlined;
      case 'Home':
      case 'Home & Living':
        return Icons.lightbulb_outline_rounded;
      default:
        return Icons.shopping_bag_outlined;
    }
  }

  List<Color> _getCategoryGradient(String category) {
    switch (category) {
      case 'Electronics':
        return [const Color(0xFFEFF6FF), const Color(0xFFDBEAFE)];
      case 'Fashion':
        return [const Color(0xFFFDF2F8), const Color(0xFFFCE7F3)];
      case 'Accessories':
        return [const Color(0xFFECFEFF), const Color(0xFFCFFAFE)];
      case 'Home':
      case 'Home & Living':
        return [const Color(0xFFFFFBEB), const Color(0xFFFEF3C7)];
      default:
        return [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getCategoryGradient(product.category);
    final icon = _getCategoryIcon(product.category);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background watermark icon (subtle)
          Positioned(
            right: -15,
            bottom: -15,
            child: Icon(
              icon,
              size: height > 150 ? 110 : 70,
              color: AppTheme.primaryColor.withValues(alpha: 0.05),
            ),
          ),

          // Main Product Asset Image (Unobscured hero visual)
          Image.asset(
            product.image,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: gradient.first,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: height > 150 ? 56 : 36,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
