import 'package:product_manager/app/shared/models/product_model.dart';

abstract class IProductRepository {
  Future<ProductModel> insertOrUpdateProduct({
    required String name,
    required double price,
    required String id,
    String? imgUrl,
    double? promotionPrice,
    int? available = 1,
  });

  Future<void> removeProduct({required String id});

  Future<void> getAllProducts();
}
