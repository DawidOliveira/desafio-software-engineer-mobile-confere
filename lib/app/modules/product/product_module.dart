import 'package:product_manager/app/modules/product/product_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => ProductPage(id: args.params['id'] as String)),
  ];
}
