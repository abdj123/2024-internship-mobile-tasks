import 'dart:io';

import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/create_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/mockito.dart';

class MockProductBloc extends Mock implements ProductBloc {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late MockProductBloc mockProductBloc;
  late MockImagePicker mockImagePicker;

  const newProduct = ProductEntity(
      id: "",
      name: 'Test Product',
      description: 'Test Product Description',
      price: '1520',
      imageUrl: 'path/to/fake/image.png');

  setUp(
    () {
      mockProductBloc = MockProductBloc();
      mockImagePicker = MockImagePicker();
      HttpOverrides.global = null;
    },
  );

  Future<void> pumpCreateProductScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: const CreateProduct(),
        ),
      ),
    );
  }

  // Widget pumpCreateProductScreen(Widget body) {
  //   return BlocProvider<ProductBloc>(
  //     create: (context) => mockProductBloc,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }

  testWidgets('this should test create product', (widgetTester) async {
    //arange
    await pumpCreateProductScreen(widgetTester);

    // await widgetTester
    //     .pumpWidget(pumpCreateProductScreen(const CreateProduct()));
    await widgetTester.pumpAndSettle(); // This ensures everything is rendered

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    //act

    // await widgetTester.enterText(
    //     find.byKey(const Key('name_field')), 'Test Product');

    // await widgetTester.enterText(
    //     find.byKey(const Key('category_field')), 'Test Catagory');

    // await widgetTester.enterText(find.byKey(const Key('price_field')), '1520');

    // await widgetTester.enterText(
    //     find.byKey(const Key('description_field')), 'Test Product Description');

    // final mockImageFile = File('path/to/fake/image.png');
    // when(mockImagePicker.pickImage(source: ImageSource.gallery))
    //     .thenAnswer((_) async => XFile(mockImageFile.path));

    // await widgetTester.tap(find.byKey(const Key('image_picker')));
    // await widgetTester.pump();

    //assert

    // expect(find.byType(Image), findsOne);

    // await widgetTester.tap(find.text('ADD'));
    // await widgetTester.pump();

    // verify(mockProductBloc.add(CreateProductEvent(newProduct))).called(1);
    // // verify(mockProductBloc.add(any<CreateProductEvent>())).called(1);

    // when(mockProductBloc.state)
    //     .thenReturn(const SuccessState("Product added successfully"));

    // expect(find.byType(SnackBar), findsOneWidget);
  });
}
