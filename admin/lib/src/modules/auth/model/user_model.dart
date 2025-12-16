import '../../../shared/export/app_export.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.instance() {
    return UserModel(
      id: '',
      email: '',
      name: '',
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['user_metadata']['name'] as String? ?? 'Usuário',
    );
  }

  @override
  List<Object?> get props => [id, email, name];
}
