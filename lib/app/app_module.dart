import 'package:flutter_modular/flutter_modular.dart';
import 'package:product_manager/app/modules/add_product/add_product_module.dart';
import 'package:product_manager/app/modules/product/product_module.dart';
import 'package:product_manager/app/repositories/product/product_repository.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ProductRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/add-product', module: AddProductModule()),
    ModuleRoute('/product', module: ProductModule()),
  ];
}
