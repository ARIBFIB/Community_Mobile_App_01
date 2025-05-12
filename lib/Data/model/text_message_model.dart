import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companio_community_chat_firebase/domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({
    required String senderName,
    required String sederUID,
    required String recipientName,
    required String recipientUID,
    required String messageType,
    required String message,
    required String messageId,
    required Timestamp time,
  }) : super(
    senderName: senderName,
    sederUID: sederUID,
    recipientName: recipientName,
    recipientUID: recipientUID,
    messsageType: messageType,
    message: message,
    messageId: messageId,
    time: time,
  );

  // Factory constructor to create an instance from a Firestore snapshot
  factory TextMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return TextMessageModel(
      senderName: data['senderName'] ?? '',
      sederUID: data['sederUID'] ?? '',
      recipientName: data['recipientName'] ?? '',
      recipientUID: data['recipientUID'] ?? '',
      messageType: data['messageType'] ?? '',
      message: data['message'] ?? '',
      messageId: data['messageId'] ?? '',
      time: data['time'] ?? Timestamp.now(), // Default to the current time if not provided
    );
  }

  // Method to convert the TextMessageModel to a Map for Firestore
  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "sederUID": sederUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "messageType": messsageType,
      "message": message,
      "messageId": messageId,
      "time": time,
    };
  }
}
