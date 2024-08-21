import 'package:first_application/features/product/domain/entities/product.dart';

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/detail_page.dart';
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
