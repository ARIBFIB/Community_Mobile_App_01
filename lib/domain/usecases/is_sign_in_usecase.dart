
import 'package:companio_community_chat_firebase/domain/repositories/firebase_repository.dart';

class IsSignInUseCase{
  final FirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async{
    return await repository.isSignIn();
  }
}