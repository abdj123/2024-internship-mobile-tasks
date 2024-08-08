import 'dart:convert';

import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getAllProduct();
  Future<void> deleteProduct(String id);
  Future<void> insertProduct(ProductEntity product);
  Future<void> updateProduct(String id);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await client.get(Uri.parse(Urls.getProduct(id)));

    if (response.statusCode == 200) {
      return ProductModel.fromJsonData(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    List<ProductModel> allProducts = [];
    final response = await client.get(Uri.parse(Urls.baseUrl));

    if (response.statusCode == 200) {
      // return ProductModel.fromJson(json.decode(response.body));

      final data = jsonDecode(response.body);
      data['data']
          .forEach((el) async => {allProducts.add(ProductModel.fromJson(el))});
      return allProducts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.getProduct(id)));

    if (response.statusCode == 200) {
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> insertProduct(ProductEntity product) async {
    final Map<String, String> mapper = {
      'image': product.imageUrl,
      'name': product.name,
      'description': product.description,
      'price': '${product.price}'
    };
    final response =
        await client.post(Uri.parse(Urls.baseUrl), headers: mapper);

    if (response.statusCode == 201) {
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(String id) async {
    final Map<String, String> mapper = {
      "name": "TV",
      "description": "36' TV",
      "price": "123.4"
    };
    final response =
        await client.put(Uri.parse(Urls.getProduct(id)), headers: mapper);

    if (response.statusCode == 200) {
    } else {
      throw ServerException();
    }
  }
}
