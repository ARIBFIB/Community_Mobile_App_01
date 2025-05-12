

import 'package:companio_community_chat_firebase/domain/repositories/firebase_repository.dart';

class SignOutUseCase{
  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call()async{
    return await repository.signOut();
  }
}