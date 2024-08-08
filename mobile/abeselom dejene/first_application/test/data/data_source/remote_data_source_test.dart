import 'package:first_application/core/constants/constants.dart';
import 'package:first_application/core/error/exception.dart';
import 'package:first_application/features/product/data/data_sources/remote_data_source.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/helpers_test.mocks.dart';
import '../../helpers/json_reader.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testId = '6672776eb905525c145fe0bb';

  group('get Product Detail', () {
    test('should return Product model when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.getProduct(testId)))).thenAnswer(
          (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_product_response.json'), 200));

      //act
      final result = await productRemoteDataSourceImpl.getProductById(testId);

      //assert
      expect(result, isA<ProductModel>());
    });

    test('should return All Product when the response code is 200', () async {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.baseUrl))).thenAnswer((_) async =>
          http.Response(
              readJson('helpers/dummy_data/dummy_product_response.json'), 200));

      //act
      final result = await productRemoteDataSourceImpl.getAllProduct();

      //assert
      expect(result[0], isA<ProductModel>());
    });

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        //arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.getProduct(testId))),
        ).thenAnswer((_) async => http.Response('Not found', 404));

        //act
        final result = productRemoteDataSourceImpl.getProductById(testId);

        //assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
