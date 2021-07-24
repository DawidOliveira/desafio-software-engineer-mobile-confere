import 'package:product_manager/app/core/db_utils.dart';
import 'package:product_manager/app/repositories/product/product_repository_interface.dart';
import 'package:product_manager/app/shared/models/product_model.dart';

class ProductRepository implements IProductRepository {
  @override
  Future<ProductModel> insertOrUpdateProduct(
      {required String name,
      required double price,
      required String id,
      String? imgUrl,
      double? promotionPrice,
      int? available = 1}) async {
    try {
      final product = ProductModel(
        id: id,
        name: name,
        price: price,
        available: available,
        imgUrl: imgUrl,
        promotionPrice: promotionPrice,
        discountPercentage: promotionPrice != null && promotionPrice > 0
            ? (price - promotionPrice) / price
            : null,
      );
      await DBUtils.insertOrUpdate(
        table: 'products',
        values: {
          'id': product.id,
          'name': name,
          'price': price,
          'img_url': imgUrl,
          'promotion_price': promotionPrice,
          'discount_percentage': promotionPrice != null && promotionPrice > 0
              ? (price - promotionPrice) / price
              : null,
          'available': available,
        },
      );
      return product;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeProduct({required String id}) async {
    try {
      await DBUtils.remove(
        table: 'products',
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await DBUtils.getData(table: 'products') as List;
      final list = response
          .map((e) => ProductModel.fromMap({
                'id': e['id'],
                'name': e['name'],
                'imgUrl': e['img_url'],
                'price': e['price'],
                'promotionPrice': e['promotion_price'] ?? 0.0,
                'available': e['available'],
                'discountPercentage': e['discount_percentage'] ?? 0.0,
              }))
          .toList();
      if (list.isEmpty) return List.empty();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
