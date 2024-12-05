// cart_item.dart
class CartItem {
  final int id;
  final String name;
  int quantity;
  final double price;
  final double? discountedPrice;
  final String image;
  int? warehouseId;

  CartItem({required this.id, required this.name, required this.quantity, required this.price, this.discountedPrice, required this.image, this.warehouseId,});
}