

import 'package:companio_community_chat_firebase/domain/entities/user_entity.dart';
import 'package:companio_community_chat_firebase/domain/repositories/firebase_repository.dart';

class GetAllUserUseCase{
  final FirebaseRepository repository;

  GetAllUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(){
    return repository.getAllUsers();
  }

}