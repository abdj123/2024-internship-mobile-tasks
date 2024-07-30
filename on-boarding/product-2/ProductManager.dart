import 'product.dart';

class ProductManager {
  List<Product> _products = [];

  void addProduct(Product product) {
    _products.add(product);
    print('Product added: $product');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.');
    } else {
      _products.forEach((product) => print(product));
    }
  }

  void viewProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('Product not found.');
    } else {
      print(_products[index]);
    }
  }

  void editProduct(int index, String name, String description, double price) {
    if (index < 0 || index >= _products.length) {
      print('Product not found.');
    } else {
      var product = _products[index];
      product.name = name;
      product.description = description;
      product.price = price;
      print('Product updated: $product');
    }
  }

  void deleteProduct(int index) {
    if (index < 0 || index >= _products.length) {
      print('Product not found.');
    } else {
      var removedProduct = _products.removeAt(index);
      print('Product removed: $removedProduct');
    }
  }
}
