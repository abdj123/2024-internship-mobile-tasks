import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:first_application/features/product/domain/entities/product.dart';

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/detail_page.dart';
import 'package:first_application/features/product/presentation/screens/home_page.dart';
import 'package:first_application/features/product/presentation/widgets/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    HttpOverrides.global = null;
  });

  const testProductEntityList = [
    ProductModel(
        id: '1',
        name: 'Test Pineapple',
        description: 'A yellow pineapple for the summer',
        imageUrl: 'https://picsum.photos/250?image=9',
        price: 5.33)
  ];

  const productEntity = ProductEntity(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'https://picsum.photos/250?image=9',
    price: 10.0,
  );

  Future<void> _pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: const DetailPage(productEntity: productEntity),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('Navigates to DetailPage on tapping product',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(
        const LoadedAllProductState(allProducts: testProductEntityList));

    // Act
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>.value(value: mockProductBloc),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/detail_page': (context) =>
                const DetailPage(productEntity: productEntity),
          },
          home: const HomePage(),
          builder: EasyLoading.init(),
        ),
      ),
    );
    await tester.tap(find.byType(ReusableCard));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Men’s shoe'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    expect(find.text("July 14, 2023"), findsOneWidget);
  });

  testWidgets('check some text', (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    await _pumpWidget(tester);

    expect(find.text("Men’s shoe"), findsOneWidget);
  });

  testWidgets('Product Delete success', (WidgetTester tester) async {
    //arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    //act
    await _pumpWidget(tester);

    await tester.tap(find.text('DELETE'));
    await tester.pump();

    // Assert
    verify(() => mockProductBloc.add(DeleteProductEvent('1'))).called(1);
  });

  testWidgets('check some text', (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    await _pumpWidget(tester);

    expect(find.text("Men’s shoe"), findsOneWidget);
  });

  testWidgets('Homepage shows error message when state is error',
      (WidgetTester tester) async {
    when(() => mockProductBloc.state).thenReturn(ProductInitial());
    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable([const ErrorState('error occured')]),
      initialState: ProductInitial(),
    );

    //act
    await _pumpWidget(tester);

    await tester.tap(find.text('DELETE'));
    await tester.pump();

    // Assert
    expect(find.byKey(const Key("snackbar_delet_error")), findsOneWidget);
  });
}
