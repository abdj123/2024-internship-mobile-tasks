import 'package:equatable/equatable.dart';
import 'package:first_application/features/product/data/models/product_model.dart';
import 'package:first_application/features/product/domain/entities/product.dart';
import 'package:first_application/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:first_application/features/product/domain/usecases/get_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/update_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase getProductUseCase;
  final GetAllProductUseCase getAllProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final InsertProductUseCase insertProductUseCase;

  ProductBloc(
      this.getProductUseCase,
      this.getAllProductUseCase,
      this.updateProductUseCase,
      this.deleteProductUseCase,
      this.insertProductUseCase)
      : super(ProductInitial()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getProductUseCase.execute(event.id);
      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        emit(LoadedSingleProductState(data));
      });
    });

    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await getAllProductUseCase.execute();
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
      final result =
          await updateProductUseCase.execute(event.id, event.productEntity);

      result.fold((failure) {
        emit(ErrorState(failure.message));
      }, (data) {
        return data;
      });
    });

    on<DeleteProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await deleteProductUseCase.execute(event.id);

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
        final result = await insertProductUseCase.execute(event.productEntity);

        result.fold((failure) {
          emit(ErrorState(failure.message));
        }, (data) {
          return data;
        });
      },
    );
  }
}
