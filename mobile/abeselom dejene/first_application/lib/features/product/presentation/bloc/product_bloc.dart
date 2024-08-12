import 'package:equatable/equatable.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/product_repositorie_impl.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImpl productRepositoryImpl;

  ProductBloc(this.productRepositoryImpl) : super(ProductInitial()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await productRepositoryImpl.getProduct(event.id);
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        emit(LoadedSingleProductState(data));
      });
    });

    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await productRepositoryImpl.getAllProduct();
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        List<ProductModel> newProduct = [];
        // ignore: avoid_function_literals_in_foreach_calls
        data.forEach((el) async => newProduct.add(ProductModel.fromEntity(el)));

        emit(LoadedAllProductState(allProducts: newProduct));
      });
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await productRepositoryImpl.updateProduct(
          event.id, event.productEntity);

      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        return data;
      });
    });

    on<DeleteProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await productRepositoryImpl.deleteProduct(event.id);

        result.fold((failure) {
          emit(ErrorState(failure.message));
        }, (data) {
          return data;
        });
      },
    );

    on<CreateProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result =
            await productRepositoryImpl.insertProduct(event.productEntity);

        result.fold((failure) {
          emit(ErrorState(failure.message));
        }, (data) {
          return data;
        });
      },
    );
  }
}
