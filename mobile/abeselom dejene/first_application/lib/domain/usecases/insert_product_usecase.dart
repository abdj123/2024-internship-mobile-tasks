import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/domain/entities/product.dart';
import 'package:first_application/domain/repositories/product_repository.dart';

class InsertProductUseCase {
  final ProductRepository productRepository;
  InsertProductUseCase(this.productRepository);

  Future<Either<Failure, void>> execute(ProductEntity productEntity) async {
    return await productRepository.insertProduct(productEntity);
  }
}