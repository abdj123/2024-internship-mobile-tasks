import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:first_application/features/product/data/models/product_model.dart';

void main() {
  const testProductModel = ProductModel(
      description: "this is new product",
      id: "123",
      imageUrl: "https://picsum.photos/250?image=9",
      name: "Gucci Bag",
      price: 1230);
  test(
    'this is model test',
    () async {
      expect(testProductModel, isA<ProductEntity>());
    },
  );
}
