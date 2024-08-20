// import 'dart:convert';

// import 'package:first_application/features/product/data/data_sources/local_data_source.dart';
// import 'package:first_application/features/product/data/models/product_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../helpers/helpers_test.mocks.dart';

// // class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   MockSharedPreferences mockSharedPreferences;
//   ProductLocalDataSourceImpl productLocalDataSourceImpl;

//   setUp(() {
//     mockSharedPreferences = MockSharedPreferences();
//     productLocalDataSourceImpl =
//         ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
//   });

//   const testId = '6672776eb905525c145fe0bb';
// const tProductModel = ProductModel(
//       id: "6672752cbd218790438efdb0",
//       name: "Anime website",
//       description: "Explore anime characters.",
//       price: 123,
//       imageUrl:
//           "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg");

//   group('local data source test', () {
//      test('should return product from shared preferences', () async {
//     // arrange
//     final expectedJsonString = json.encode(tProductModel.toJson());
//     when(mockSharedPreferences.getString('1')).thenReturn(expectedJsonString);

//     // act
//     final result = await productLocalDataSourceImpl.getProductById('1');

//     // assert
//     verify(mockSharedPreferences.getString('1'));
//     expect(result, tProductModel);
//   });
//   });
// }

import 'package:first_application/features/product/data/data_sources/local_data_source.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  const testId = '6672752cbd218790438efdb0';

  const tProductModel = ProductModel(
      id: "6672752cbd218790438efdb0",
      name: "Anime website",
      description: "Explore anime characters.",
      price: 123,
      imageUrl:
          "https://res.cloudinary.com/g5-mobile-track/image/upload/v1718777132/images/zxjhzrflkvsjutgbmr0f.jpg");

  // test('should insert product to shared preferences', () async {
  //   // arrange
  //   final expectedJsonString = json.encode(tProductModel.toJson());

  //   // act
  //   await dataSource.insertProduct(tProductModel);

  //   // assert
  //   verify(mockSharedPreferences.setString('1', expectedJsonString));
  // });

  test('should return product from shared preferences', () async {
    // arrange
    final expectedJsonString = json.encode(tProductModel.toJson());
    when(mockSharedPreferences.getString(testId))
        .thenReturn(expectedJsonString);

    // act
    final result = await dataSource.getProductById(testId);

    // assert
    verify(mockSharedPreferences.getString(testId));
    expect(result, tProductModel);
  });

  // test('should delete product from shared preferences', () async {
  //   // act
  //   await dataSource.deleteProduct('1');

  //   // assert
  //   verify(mockSharedPreferences.remove('1'));
  // });
}
