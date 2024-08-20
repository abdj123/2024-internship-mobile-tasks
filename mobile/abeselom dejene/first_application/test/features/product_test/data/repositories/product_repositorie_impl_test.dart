import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:first_application/core/error/exception.dart';
import 'package:first_application/core/error/failure.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:first_application/features/product/data/repositories/product_repositorie_impl.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/helpers_test.mocks.dart';

void main() async {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late ProductRepositoryImpl productRepositoryImpl;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    productRepositoryImpl = ProductRepositoryImpl(
        productRemoteDataSource: mockProductRemoteDataSource,
        localDataSource: mockAuthLocalDataSource);
  });

  final token = await mockAuthLocalDataSource.getCachedToken();

  const testProductModel = ProductModel(
      id: "6672752cbd218790438efdb0",
      name: "Anime website",
      description: "Explore anime characters.",
      price: 123,
      imageUrl:
          "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg");

  const testProductEntity = ProductEntity(
      id: "6672752cbd218790438efdb0",
      name: "Anime website",
      description: "Explore anime characters.",
      price: 123,
      imageUrl:
          "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg");

  const testProductId = '6672752cbd218790438efdb0';

  group('Repository Implementation Group', () {
    test('Repository Implimentation Test', () async {
      // arrange

      when(mockProductRemoteDataSource.getProductById(testProductId, token))
          .thenAnswer((realInvocation) async => testProductModel);

      // act

      final result = await productRepositoryImpl.getProduct(testProductId);

      // assert

      expect(result, equals(const Right(testProductEntity)));
    });
    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockProductRemoteDataSource.getProductById(testProductId, token))
            .thenThrow(ServerException());

        // act
        final result = await productRepositoryImpl.getProduct(testProductId);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockProductRemoteDataSource.getProductById(
                testProductId, token.toString()))
            .thenThrow(
                const SocketException('Failed to connect to the network'));

        // act
        final result = await productRepositoryImpl.getProduct(testProductId);

        // assert
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
