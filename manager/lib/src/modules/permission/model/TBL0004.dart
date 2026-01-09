import '../../../shared/export/app_export.dart';

extension PermissionExtension on TBL0004 {
  bool get isAdmin => type.toLowerCase() == 'admin';
  bool get isModerator => type.toLowerCase() == 'moderador';
  bool get isTeacher => type.toLowerCase() == 'professor';
  bool get isProducts => type.toLowerCase() == 'produtos';
}

class TBL0004 extends Equatable {
  final String id;
  final String user;
  final String type;
  final String email;
  final String name;

  const TBL0004({
    required this.id,
    required this.user,
    required this.type,
    required this.email,
    required this.name,
  });

  factory TBL0004.instance() {
    return TBL0004(
      id: '',
      user: '',
      type: '',
      email: '',
      name: '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toLowerCase(),
      'user': user,
      'email': email,
      'name': name,
    };
  }

  factory TBL0004.fromMap(Map<String, dynamic> map) {
    return TBL0004(
      id: map['id'] as String,
      user: map['user'] as String,
      type: map['type'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  TBL0004 copyWith({
    String? id,
    String? user,
    String? type,
    String? email,
    String? name,
  }) {
    return TBL0004(
      id: id ?? this.id,
      user: user ?? this.user,
      type: type ?? this.type,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      user,
      type,
      email,
      name,
    ];
  }
}
