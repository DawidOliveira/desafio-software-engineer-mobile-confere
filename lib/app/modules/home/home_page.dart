import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:product_manager/app/modules/home/home_controller.dart';
import 'package:product_manager/app/shared/models/product_model.dart';
import 'widgets/list_item/list_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  bool _isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: !_isSearch
            ? const Text('Produtos')
            : TextField(
                autofocus: true,
                onChanged: (value) {
                  controller.setSearchText = value;
                },
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearch = !_isSearch;
                if (_isSearch == false) {
                  controller.searchText.value = "";
                }
              });
            },
            icon: Icon(_isSearch ? Icons.close : Icons.search),
          )
        ],
      ),
      body: StreamBuilder<List<ProductModel>?>(
          stream: controller.productsFiltered,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return ListItemWidget(
                  available: product.available == 1,
                  controller: controller,
                  name: product.name,
                  price: product.price,
                  promotionPrice: product.promotionPrice == 0
                      ? null
                      : product.promotionPrice,
                  imgUrl: product.imgUrl,
                  discountPercentage: product.discountPercentage,
                  id: product.id,
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 0,
              ),
              itemCount: snapshot.data!.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.imgUrl.value = "";
          Navigator.of(context).pushNamed(
            '/add-product',
            arguments: {
              'id': '',
              'controller': controller,
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
