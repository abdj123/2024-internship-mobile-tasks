import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:first_application/features/product/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;
  UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, bool>> execute(
      String id, ProductEntity productEntity) async {
    return await productRepository.updateProduct(id, productEntity);
  }
}
