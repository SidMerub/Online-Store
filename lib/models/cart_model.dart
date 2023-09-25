class CartItem {
  final String name;
  final String image;
  int quantity;
  final double price;
  final int availableQuantity;

  CartItem({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.availableQuantity,
  });
}
