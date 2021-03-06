import 'package:flutter/widgets.dart';
import 'package:shopping/repositories/category.repository.dart';

import '../models/category-list-item.model.dart';
import '../models/product-list-item.model.dart';
import '../repositories/product.repository.dart';

class HomeBloc extends ChangeNotifier{
  final categoryRepository = new CategoryRepository();
  final productRepository = new ProductRepository();

  List<ProductListItemModel> products;
  List<CategoryListItemModel> categories;

  String selectedCategory = 'Todos';

  HomeBloc(){
    getCategories();
    getProducts();
  }

  getCategories() {
    categoryRepository.getAll().then((data) {
      this.categories = data;      
      notifyListeners();
    });
  }

  getProducts() {
    productRepository.getAll().then((data) {
      this.products = data;
      notifyListeners();
    });
  }

  getProductsByCategory() {
    productRepository.getByCategory(selectedCategory).then((data) {
      this.products = data;
      notifyListeners();
    });
  }

  changeCategory(tag) {
    selectedCategory = tag;
    products = null;
    getProductsByCategory();
  }
}
