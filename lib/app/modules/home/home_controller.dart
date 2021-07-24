import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_manager/app/repositories/product/product_repository.dart';
import 'package:product_manager/app/shared/models/product_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class HomeController extends Disposable {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final available = BehaviorSubject<int?>.seeded(1);
  final imgUrl = BehaviorSubject<String?>.seeded("");
  final products = BehaviorSubject<List<ProductModel>?>();
  final productsFiltered = BehaviorSubject<List<ProductModel>?>();
  final searchText = BehaviorSubject<String>();

  final ProductRepository _productRepository;

  HomeController(this._productRepository) {
    init();
    filterChange();
  }

  set setSearchText(String value) => searchText.value = value;

  void filterChange() {
    searchText.listen((value) {
      productsFiltered.value = products.value!
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (value.isEmpty) {
        productsFiltered.value = products.value;
      }
    });
  }

  Future<void> init() async {
    products.value = (await _productRepository.getAllProducts())
      ..sort((a, b) => a.name.compareTo(b.name));
    productsFiltered.value = products.value;
  }

  set setAvailable(int? value) => available.value = value;

  Future<void> addNewProduct({
    required String name,
    required double price,
    String? id,
    double? promotionPrice,
  }) async {
    final response = await _productRepository.insertOrUpdateProduct(
      name: name,
      price: price,
      id: id ?? const Uuid().v4(),
      available: available.value,
      imgUrl: imgUrl.value,
      promotionPrice: promotionPrice,
    );
    final product = ProductModel(
      id: response.id,
      name: name,
      price: price,
      available: response.available,
      discountPercentage: response.discountPercentage,
      imgUrl: response.imgUrl,
      promotionPrice: response.promotionPrice,
    );
    if (id == null) {
      products.value = List.from([...products.value!, product])
        ..sort((a, b) => a.name.compareTo(b.name));
    } else {
      products.value![
          products.value!.indexWhere((element) => element.id == id)] = product;
    }
    productsFiltered.value = products.value;
    imgUrl.value = "";
  }

  Future<void> removeProduct({required String id}) async {
    await _productRepository.removeProduct(id: id);
    products.value!.removeWhere((element) => element.id == id);
    productsFiltered.value = products.value;
  }

  ProductModel getProduct(String id) =>
      products.value!.firstWhere((element) => element.id == id);

  Future<String> saveImage() async {
    final imgPicker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imgPicker == null) return "";
    final String path = (await getApplicationDocumentsDirectory()).path;
    await imgPicker.saveTo('$path/${imgPicker.name}');
    imgUrl.value = '$path/${imgPicker.name}';
    return '$path/${imgPicker.name}';
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return 'Preencha o campo corretamente';
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.isEmpty || double.parse(value) <= 0) {
      return 'Valor inválido';
    }
    return null;
  }

  @override
  void dispose() {
    available.close();
    imgUrl.close();
    products.close();
  }
}
