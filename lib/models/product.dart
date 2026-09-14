class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double oldPrice;
  final String image;
  final String description;
  final double rating;
  final int reviewCount;
  bool isFavorite;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.description,
    required this.rating,
    required this.reviewCount,
    this.isFavorite = false,
    this.inStock = true,
  });

  int get discountPercent {
    if (oldPrice > price) {
      return (((oldPrice - price) / oldPrice) * 100).round();
    }
    return 0;
  }
}
