import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companio_community_chat_firebase/domain/entities/my_chat_entity.dart';

class MyChatModel extends MyChatEntity {
  MyChatModel({
    required String senderName,
    required String senderUID,
    required String recipientName,
    required String recipientUID,
    required String channelId,
    required String profileURL,
    required String recipientPhoneNumber,
    required String senderPhoneNumber,
    required String recentTextMessage,
    required bool isRead,
    required bool isArchived,
    required Timestamp time,
  }) : super(
    senderName: senderName,
    senderUID: senderUID,
    recipientName: recipientName,
    recipientUID: recipientUID,
    channelId: channelId,
    profileURL: profileURL,
    recipientPhoneNumber: recipientPhoneNumber,
    senderPhoneNumber: senderPhoneNumber,
    recentTextMessage: recentTextMessage,
    isRead: isRead,
    isArchived: isArchived,
    time: time,
  );

  // Factory constructor to create an instance from a Firestore snapshot
  factory MyChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return MyChatModel(
      senderName: data['senderName'] ?? '',
      senderUID: data['senderUID'] ?? '',
      senderPhoneNumber: data['senderPhoneNumber'] ?? '',
      recipientName: data['recipientName'] ?? '',
      recipientUID: data['recipientUID'] ?? '',
      recipientPhoneNumber: data['recipientPhoneNumber'] ?? '',
      channelId: data['channelId'] ?? '',
      time: data['time'] ?? Timestamp.now(),
      isArchived: data['isArchived'] ?? false,
      isRead: data['isRead'] ?? false,
      recentTextMessage: data['recentTextMessage'] ?? '',
      profileURL: data['profileURL'] ?? '',
    );
  }

  // Method to convert the MyChatModel to a Map for Firestore
  Map<String, dynamic> toDocument() {
    return {
      "senderName": senderName,
      "senderUID": senderUID,
      "recipientName": recipientName,
      "recipientUID": recipientUID,
      "channelId": channelId,
      "profileURL": profileURL,
      "recipientPhoneNumber": recipientPhoneNumber,
      "senderPhoneNumber": senderPhoneNumber,
      "recentTextMessage": recentTextMessage,
      "isRead": isRead,
      "isArchived": isArchived,
      "time": time,
    };
  }
}
