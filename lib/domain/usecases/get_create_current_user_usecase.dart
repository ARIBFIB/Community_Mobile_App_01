
import 'package:companio_community_chat_firebase/domain/entities/user_entity.dart';
import 'package:companio_community_chat_firebase/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase{
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return await repository.getCreateCurrentUser(user);
  }
}