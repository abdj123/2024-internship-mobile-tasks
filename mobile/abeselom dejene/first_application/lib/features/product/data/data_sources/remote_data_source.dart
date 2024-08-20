import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getProductById(String id, String token);
  Future<List<ProductModel>> getAllProduct(String token);
  Future<bool> deleteProduct(String id, String token);
  Future<bool> insertProduct(ProductEntity product, String token);
  Future<bool> updateProduct(
      String id, ProductEntity productEntity, String token);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getProductById(String id, String token) async {
    final response = await client.get(Uri.parse(Urls.getProduct(id)), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return ProductModel.fromJsonData(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProduct(String token) async {
    List<ProductModel> allProducts = [];
    final response = await client.get(Uri.parse(Urls.baseUrl), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['data']
          .forEach((el) async => {allProducts.add(ProductModel.fromJson(el))});
      return allProducts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteProduct(String id, String token) async {
    final response =
        await client.delete(Uri.parse(Urls.getProduct(id)), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> insertProduct(ProductEntity product, String token) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(Urls.baseUrl));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields.addAll({
        'name': product.name,
        'description': product.description,
        'price': product.price
      });

      request.files.add(await http.MultipartFile.fromPath(
          'image', product.imageUrl,
          contentType: MediaType('image', 'png')));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateProduct(
      String id, ProductEntity productEntity, String token) async {
    final Map<String, dynamic> mapper = {
      "name": productEntity.name,
      "description": productEntity.description,
      "price": int.tryParse(productEntity.price),
    };

    final encoded = json.encode(mapper);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('PUT', Uri.parse(Urls.getProduct(id)));
    request.body = encoded;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
