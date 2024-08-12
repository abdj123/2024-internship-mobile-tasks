import '../../domain/entities/product.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required dynamic price,
  }) : super(
          description: description,
          id: id,
          imageUrl: imageUrl,
          name: name,
          price: price,
        );

  factory ProductModel.fromJsonData(Map<String, dynamic> json) => ProductModel(
        id: json['data']['id'],
        name: json['data']['name'],
        description: json['data']['description'],
        imageUrl: json['data']['imageUrl'],
        price: json['data']['price'],
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price'],
      );

  static ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      price: entity.price,
    );
  }

  factory ProductModel.forLocalJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        price: json['price'] as int,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'description': description,
      };

  Map<String, String> toMap() => {
        'id': id,
        'name': name,
        'price': '$price',
        'imageUrl': imageUrl,
        'description': description,
      };

  ProductEntity toEntity() => ProductEntity(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        price: price,
      );
}
