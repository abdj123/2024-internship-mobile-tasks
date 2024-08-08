import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProduct(String id);
  Future<Either<Failure, void>> insertProduct(ProductEntity product);
  Future<Either<Failure, void>> updateProduct(ProductEntity product);
  Future<Either<Failure, void>> deleteProduct(String id);
  Future<Either<Failure, List<ProductEntity>>> getAllProduct();
}
