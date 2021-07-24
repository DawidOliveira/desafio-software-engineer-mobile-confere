import 'package:flutter_modular/flutter_modular.dart';
import 'package:product_manager/app/modules/add_product/add_product_page.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';

class AddProductModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => AddProductPage(
        controller: args.data['controller'] as HomeController,
        productId: args.data['id'] as String,
      ),
    ),
  ];
}
