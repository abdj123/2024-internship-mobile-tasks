import 'package:bloc_test/bloc_test.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:first_application/features/product/presentation/screens/create_product.dart';
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
  });

  Future<void> _pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: const CreateProduct(),
        ),
      ),
    );
  }

  Future<void> _pumpUpdateWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: const CreateProduct(),
        ),
      ),
    );
  }

  testWidgets('shows success Snackbar on successful product creation',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    await _pumpWidget(tester);

    expect(find.byKey(const Key('name_field')), findsOneWidget);
  });

  //   hiii
  testWidgets('shows error Snackbar on product creation failure',
      (WidgetTester tester) async {
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable(
          [const ErrorState('Failed to create product')]),
    );

    await _pumpWidget(tester);

    await tester.ensureVisible(find.text('ADD'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('image_picker')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('name_field')), 'Test Product');
    await tester.enterText(
        find.byKey(const Key('category_field')), 'Test Category');
    await tester.enterText(find.byKey(const Key('price_field')), '50');
    await tester.enterText(
        find.byKey(const Key('description_field')), 'Test Description');

    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('error_snackbar')), findsOneWidget);
  });

  testWidgets('shows success Snackbar on product creation',
      (WidgetTester tester) async {
    when(() => mockProductBloc.state).thenReturn(ProductInitial());

    whenListen(
      mockProductBloc,
      Stream<ProductState>.fromIterable(
          [const SuccessState('Product Created!')]),
    );

    await _pumpWidget(tester);

    await tester.ensureVisible(find.text('ADD'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('image_picker')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('name_field')), 'Test Product');
    await tester.enterText(
        find.byKey(const Key('category_field')), 'Test Category');
    await tester.enterText(find.byKey(const Key('price_field')), '50');
    await tester.enterText(
        find.byKey(const Key('description_field')), 'Test Description');

    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('success_snackbar')), findsOneWidget);
  });
}
