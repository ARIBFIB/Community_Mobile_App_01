

import 'package:companio_community_chat_firebase/domain/entities/contact_entity.dart';
import 'package:companio_community_chat_firebase/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberUseCase{
  final GetDeviceNumberRepository deviceNumberRepository;

  GetDeviceNumberUseCase({required this.deviceNumberRepository});

  Future<List<ContactEntity>> call()async{
    return deviceNumberRepository.getDeviceNumbers();
  }
}