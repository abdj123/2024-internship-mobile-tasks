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
  InsertProductUseCase
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
