import 'dart:io';
import 'ProductManager.dart';
import 'product.dart';

void main() {
  var productManager = ProductManager();
  while (true) {
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Choose an option: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        var name = stdin.readLineSync() ?? '';
        stdout.write('Enter product description: ');
        var description = stdin.readLineSync() ?? '';
        stdout.write('Enter product price: ');
        var price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
        var product = Product(name, description, price);
        productManager.addProduct(product);
        break;
      case '2':
        productManager.viewAllProducts();
        break;
      case '3':
        stdout.write('Enter product index: ');
        var index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        productManager.viewProduct(index);
        break;
      case '4':
        stdout.write('Enter product index: ');
        var index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        stdout.write('Enter new product name: ');
        var newName = stdin.readLineSync() ?? '';
        stdout.write('Enter new product description: ');
        var newDescription = stdin.readLineSync() ?? '';
        stdout.write('Enter new product price: ');
        var newPrice = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
        productManager.editProduct(index, newName, newDescription, newPrice);
        break;
      case '5':
        stdout.write('Enter product index: ');
        var index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        productManager.deleteProduct(index);
        break;
      case '6':
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}
