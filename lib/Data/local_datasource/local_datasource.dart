import 'package:flutter_contacts/flutter_contacts.dart';  // Add this import for Flutter contacts
import 'package:permission_handler/permission_handler.dart';  // Add this import for permission handling
import 'package:companio_community_chat_firebase/domain/entities/contact_entity.dart';

abstract class LocalDataSource {
  Future<List<ContactEntity>> getDeviceNumbers();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<ContactEntity>> getDeviceNumbers() async {
    List<ContactEntity> contacts = [];

    // Request permission to access contacts
    PermissionStatus permissionStatus = await Permission.contacts.request();

    // Check if permission is granted
    if (permissionStatus.isGranted) {
      // Fetch contacts using FlutterContacts
      final contactsList = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);

      // Extract the necessary data and store it in ContactEntity
      for (var contact in contactsList) {
        if (contact.phones.isNotEmpty) {
          contact.phones.forEach((phoneData) {
            contacts.add(ContactEntity(
              phoneNumber: phoneData.number,
              label: contact.displayName ?? '',
              uid: '',  // Assuming you don't need UID, otherwise, you can generate or fetch from elsewhere
              status: '',  // Add status if necessary
            ));
          });
        }
      }
    } else {
      // Handle permission denial
      throw Exception("Permission to access contacts is denied");
    }

    return contacts;
  }
}
