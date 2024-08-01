import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository productRepository;
  DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> execute(String id) async {
    return await productRepository.deleteProduct(id);
  }
}
