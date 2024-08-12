import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:first_application/features/product/domain/repositories/product_repository.dart';

import '../../../../core/error/exception.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  late ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    try {
      final result = await productRemoteDataSource.deleteProduct(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(String id) async {
    try {
      final result = await productRemoteDataSource.getProductById(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> insertProduct(ProductEntity product) async {
    try {
      final result = await productRemoteDataSource.insertProduct(product);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateProduct(
      String id, ProductEntity product) async {
    try {
      final result = await productRemoteDataSource.updateProduct(id, product);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProduct() async {
    try {
      final result = await productRemoteDataSource.getAllProduct();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
