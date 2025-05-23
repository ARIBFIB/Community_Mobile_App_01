
import 'package:companio_community_chat_firebase/domain/repositories/firebase_repository.dart';

class CreateOneToOneChatChannelUseCase{
  final FirebaseRepository repository;

  CreateOneToOneChatChannelUseCase({required this.repository});

  Future<void> call(String uid,String otherUid)async{
    return repository.createOneToOneChatChannel(uid, otherUid);
  }
}