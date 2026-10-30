import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract final class UserMapper {
  static User toEntity(UserModel model) =>
      User(name: model.name, email: model.email);

  static UserModel fromEntity(User entity) =>
      UserModel(name: entity.name, email: entity.email);
}