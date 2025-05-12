

import 'package:companio_community_chat_firebase/data/local_datasource/local_datasource.dart';
import 'package:companio_community_chat_firebase/domain/entities/contact_entity.dart';
import 'package:companio_community_chat_firebase/domain/repositories/get_device_number_repository.dart';

class GetDeviceNumberRepositoryImpl implements GetDeviceNumberRepository{
  final LocalDataSource localDataSource;

  GetDeviceNumberRepositoryImpl({required this.localDataSource});
  @override
  Future<List<ContactEntity>> getDeviceNumbers() {
    return localDataSource.getDeviceNumbers();
  }

}