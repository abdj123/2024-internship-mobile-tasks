import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
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

  Future<void> _pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: const HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  const testProductEntityList = [
    ProductModel(
        id: '1',
        name: 'Test Pineapple',
        description: 'A yellow pineapple for the summer',
        imageUrl: 'https://picsum.photos/250?image=9',
        price: 5.33)
  ];

  testWidgets('check some text', (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    await _pumpWidget(tester);

    expect(find.text("July 14, 2023"), findsOneWidget);
  });

  testWidgets('shows circular progress bar while loading',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(LoadingState());

    await _pumpWidget(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePage should have ReusableCard', (WidgetTester tester) async {
    //arrange
    when(() => mockProductBloc.state).thenReturn(
        const LoadedAllProductState(allProducts: testProductEntityList));

    //act
    await _pumpWidget(tester);

    expect(find.byType(ReusableCard), findsWidgets);
  });

  testWidgets('Homepage shows error message when state is error',
      (WidgetTester tester) async {
    //arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable(
          [const ErrorState('Failed to Fetch products')]),
    );

    //act
    await _pumpWidget(tester);

    // assert

    expect(find.byKey(const Key("error_snackbar_home")), findsWidgets);
  });
}
