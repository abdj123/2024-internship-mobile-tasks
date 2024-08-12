import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:first_application/features/product/domain/repositories/product_repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;
  GetProductUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> execute() async {
    return await productRepository.getAllProduct();
  }
}
