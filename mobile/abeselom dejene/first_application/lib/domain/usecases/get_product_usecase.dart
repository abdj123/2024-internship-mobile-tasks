import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/domain/entities/product.dart';
import 'package:first_application/domain/repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;
  GetProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(String id) async {
    return await productRepository.getProduct(id);
  }
}
