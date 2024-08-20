import 'package:first_application/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:first_application/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:first_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:first_application/features/authentication/domain/usecases/log_in_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/log_out_usecase.dart';
import 'package:first_application/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:first_application/features/product/data/data_sources/remote_data_source.dart';
import 'package:first_application/features/product/domain/repositories/product_repository.dart';
import 'package:first_application/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:first_application/features/product/domain/usecases/get_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/insert_product_usecase.dart';
import 'package:first_application/features/product/domain/usecases/update_product_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
  SharedPreferences,
  InternetConnectionChecker,
  GetProductUseCase,
  GetAllProductUseCase,
  DeleteProductUseCase,
  UpdateProductUseCase,
  InsertProductUseCase,
  // auth
  UserRepository,
  UserRemoteDataSource,
  LoginUseCase,
  SignUpUseCase,
  LogOutUseCase,
  AuthLocalDataSource
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
