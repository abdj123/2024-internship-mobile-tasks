class Urls {
  static const String baseUrl =
      "https://g5-flutter-learning-path-be.onrender.com/api/v2/products";

  // old api
  // 'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';

  static const String baseUrlV2 =
      "https://g5-flutter-learning-path-be.onrender.com/api/v2";
  static String getProduct(String id) => '$baseUrl/$id';
  static String loginUrl = '$baseUrlV2/auth/login';
  static String registerUrl = '$baseUrlV2/auth/register';
}
