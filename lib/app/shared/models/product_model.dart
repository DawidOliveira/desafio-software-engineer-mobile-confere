import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String? imgUrl;
  final double price;
  final double? promotionPrice;
  final int? available;
  final double? discountPercentage;

  ProductModel({
    required this.id,
    required this.name,
    this.imgUrl,
    required this.price,
    this.promotionPrice,
    this.available,
    this.discountPercentage,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    double? price,
    double? promotionPrice,
    int? available,
    double? discountPercentage,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      promotionPrice: promotionPrice ?? this.promotionPrice,
      available: available ?? this.available,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
      'promotionPrice': promotionPrice,
      'available': available,
      'discountPercentage': discountPercentage,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      imgUrl: map['imgUrl'].toString(),
      price: map['price'] as double,
      promotionPrice: map['promotionPrice'] as double,
      available: map['available'] as int,
      discountPercentage: map['discountPercentage'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, imgUrl: $imgUrl, price: $price, promotionPrice: $promotionPrice, available: $available, discountPercentage: $discountPercentage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.price == price &&
        other.promotionPrice == promotionPrice &&
        other.available == available &&
        other.discountPercentage == discountPercentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        price.hashCode ^
        promotionPrice.hashCode ^
        available.hashCode ^
        discountPercentage.hashCode;
  }
}
