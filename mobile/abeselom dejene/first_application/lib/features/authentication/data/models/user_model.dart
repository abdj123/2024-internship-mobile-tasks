import 'package:first_application/features/authentication/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.name,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  factory UserModel.fromJsonRegiset(Map<String, dynamic> json) => UserModel(
      email: json['data']['email'],
      name: json['data']['name'],
      id: json['data']['id']);

  factory UserModel.fromJsonGetMe(Map<String, dynamic> json) => UserModel(
      email: json['data']['email'],
      name: json['data']['name'],
      id: json['data']['_id']);

  UserEntity toEntity() => UserEntity(
        email: email,
        name: name,
        id: id,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  static UserModel fromEntity(UserEntity userEntity) {
    return UserModel(
      email: userEntity.email,
      name: userEntity.name,
      id: userEntity.id,
    );
  }
}
