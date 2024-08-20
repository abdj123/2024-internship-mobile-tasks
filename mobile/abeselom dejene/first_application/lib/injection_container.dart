import 'package:first_application/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:first_application/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:first_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:first_application/features/authentication/domain/usecases/log_in_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/log_out_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:first_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:first_application/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/get_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/update_product_usecase.dart';
import 'package:first_application/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/data/datasources/auth_local_data_source.dart';
import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/data/repositories/product_repositorie_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_all_products_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // bloc
  locator.registerFactory(
      () => ProductBloc(locator(), locator(), locator(), locator(), locator()));

  // usecase
  locator.registerLazySingleton(() => GetProductUseCase(locator()));

  locator.registerLazySingleton(() => GetAllProductUseCase(locator()));

  locator.registerLazySingleton(() => DeleteProductUseCase(locator()));

  locator.registerLazySingleton(() => UpdateProductUseCase(locator()));

  locator.registerLazySingleton(() => InsertProductUseCase(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
        productRemoteDataSource: locator(), localDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());

  /*

Auth Dependancies

  **/

  // bloc
  locator.registerFactory(() => AuthBloc(locator(), locator(), locator()));

  // usecase

  locator.registerLazySingleton(() => LoginUseCase(locator()));

  locator.registerLazySingleton(() => SignUpUseCase(locator()));

  locator.registerLazySingleton(() => LogOutUseCase(locator()));

  // repository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        userRemoteDataSource: locator(), localDataSource: locator()),
  );

  // data source

  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: locator()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(
      client: locator(),
    ),
  );
}
