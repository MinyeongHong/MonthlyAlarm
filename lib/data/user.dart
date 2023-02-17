import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userId;
  final bool isLightMode;

  const User(this.userId, this.isLightMode);

  @override
  List<Object?> get props => [userId];
}