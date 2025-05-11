import 'dart:io';
import 'package:companio_community_chat_firebase/Getx/get_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:companio_community_chat_firebase/Data/Local/SharedPreference/shared_preference.dart';
import 'package:companio_community_chat_firebase/Getx/get_otp.dart';
import 'package:companio_community_chat_firebase/Getx/get_signup.dart';
import 'package:companio_community_chat_firebase/Utils/Widget/snackbar.dart';
import 'package:companio_community_chat_firebase/View/account/otp.dart';
import 'package:companio_community_chat_firebase/res/const/const.dart';

import '../../../View/HomePage/home_page.dart';

class FirebaseService {
  static String phoneNumber_ = "";
  static String name_ = "";
  static File? file_;


  // static Future<void> requestOtp(
  //     String phoneNumber, String name, File file, SignUpState state) async {
  //   phoneNumber_ = phoneNumber;
  //   name_ = name;
  //   file_ = file;
  //   state.setPress();
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //
  //     phoneNumber: '+92$phoneNumber',
  //     codeSent: (String verificationId, int? resendToken) async {
  //       state.setPress();
  //       Get.to(Otp(
  //         verificationId: verificationId,
  //       ));
  //     },
  //
  //     verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
  //     },
  //     verificationFailed: (FirebaseAuthException error) {
  //       ShowSnackBar("Error", errorRead(error.toString()));
  //       state.setPress();
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //
  //     },
  //   ).onError((error, stackTrace) {
  //     state.setPress();
  //     ShowSnackBar("Error", errorRead(error.toString()));
  //   },);
  // }

  static Future<void> requestOtp(String phoneNumber, String name, SignUpState state) async {
    try {
      phoneNumber_ = phoneNumber;
      name_ = name;
      state.setPress();  // Start the loading state
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: '+92$phoneNumber',
        codeSent: (String verificationId, int? resendToken) async {
          state.setPress();  // Stop the loading state
          Get.to(Otp(verificationId: verificationId));
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {
          ShowSnackBar("Error", error.message ?? "Unknown Error");
          state.setPress();  // Stop the loading state
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      ).onError((error, stackTrace) {
        state.setPress();  // Stop the loading state
        ShowSnackBar("Error", error.toString());
      });
    } catch (e) {
      state.setPress();  // Stop the loading state
      ShowSnackBar("Error", "Something went wrong: ${e.toString()}");
    }
  }






  // static Future<void> verifyOtp(String otp, String verificationId,OtpState controller) async {
  //   try{
  //     controller.setPress();
  //     FirebaseAuth auth = FirebaseAuth.instance;
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId, smsCode: otp);
  //     await auth.signInWithCredential(credential).then(
  //           (value) async {
  //         FirebaseStorage storage = FirebaseStorage.instance;
  //         var sref = storage.ref('$phoneNumber_.jpeg');
  //         var uploadtask = sref.putFile(file_!);
  //         await Future.value(uploadtask).then(
  //               (v) async {
  //             sref.getDownloadURL().then((url) {
  //               FirebaseDatabase.instance.ref('Accounts').child(phoneNumber_).set({
  //                 'name' : name_,
  //                 'phoneNumber' : phoneNumber_,
  //                 'url' : url
  //               }).then((value) {
  //                 SharedPref.saveData(name_, phoneNumber_, url);
  //                 controller.setPress();
  //                 ShowSnackBar("Successful", "Verified");
  //                 Get.to( HomePage());
  //               },);
  //             }).onError((error, stackTrace) {
  //               FirebaseAuth.instance.signOut();
  //               controller.setPress();
  //               ShowSnackBar("Error", errorRead(error.toString()));
  //               return;
  //             },);
  //           },
  //         ).onError(
  //               (error, stackTrace) {
  //             FirebaseAuth.instance.signOut();
  //             controller.setPress();
  //             ShowSnackBar("Error", errorRead(error.toString()));
  //             return;
  //           },
  //         );
  //       },
  //     ).onError(
  //           (error, stackTrace) {
  //             controller.setPress();
  //         ShowSnackBar("Error", errorRead(error.toString()));
  //       },
  //     );
  //   }catch (e){
  //     controller.setPress();
  //     FirebaseAuth.instance.signOut();
  //   }
  // }

  static Future<void> verifyOtp(String otp, String verificationId, OtpState controller) async {
    try {
      controller.setPress();
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      await auth.signInWithCredential(credential).then(
            (value) async {
          // Assuming you don't have a URL to save, you can pass an empty string or placeholder URL
          String url = ""; // Placeholder for URL

          FirebaseDatabase.instance.ref('Accounts').child(phoneNumber_).set({
            'name': name_,
            'phoneNumber': phoneNumber_,
            'url': url,  // Save an empty or placeholder URL
          }).then((value) {
            // Save the data to SharedPreferences (name, phone number, and URL)
            SharedPref.saveData(name_, phoneNumber_, url);  // Pass all 3 arguments
            controller.setPress();
            ShowSnackBar("Successful", "Verified");
            Get.to(HomePage());
          }).onError((error, stackTrace) {
            FirebaseAuth.instance.signOut();
            controller.setPress();
            ShowSnackBar("Error", errorRead(error.toString()));
          });
        },
      ).onError(
            (error, stackTrace) {
          controller.setPress();
          ShowSnackBar("Error", errorRead(error.toString()));
        },
      );
    } catch (e) {
      controller.setPress();
      FirebaseAuth.instance.signOut();
    }
  }





  static Future<void> sendMessage(String sender,String receiver,String name,String message,String url)async{
    FirebaseDatabase.instance.ref('Accounts').child(sender).child('Chat').child(receiver).set({
      'name' : name,
      'phoneNumber' : receiver,
      'url' : url,
      'latestMessage' : message
    });

    FirebaseDatabase.instance.ref('Accounts').child(receiver).child('Chat').child(sender).set({
      'name' : await SharedPref.getName(),
      'phoneNumber' : await SharedPref.getNumber(),
      'url' : await SharedPref.getUrl(),
      'latestMessage' : message
    });
    String time = DateFormat('h:mm:a').format(DateTime.now());
    FirebaseDatabase.instance.ref('Chats').child(sender).child(receiver).child(DateTime.now().microsecondsSinceEpoch.toString()).set({
      'sender' : sender,
      'receiver' : receiver,
      'message' : message,
      'time' : time
    });

    FirebaseDatabase.instance.ref('Chats').child(receiver).child(sender).child(DateTime.now().microsecondsSinceEpoch.toString()).set({
      'sender' : sender,
      'receiver' : receiver,
      'message' : message,
      'time' : time,
    });
  }

  static Future<void> setStatusOnline()async{
    FirebaseDatabase.instance.ref('Accounts').child(number).update({
      'status' : 'Online'
    });
  }

  static Future<void> setStatusOffline()async{
    String time = DateFormat('h:mm:a').format(DateTime.now());
    FirebaseDatabase.instance.ref('Accounts').child(number).update({
      'status' : time
    });
  }

  // static Future<void> sendImage(String sender,String receiver)async {
  //   String key=DateTime.now().microsecondsSinceEpoch.toString();
  //
  //   FirebaseDatabase.instance.ref('Chats').child(sender).child(receiver).child(key).set({
  //     'sender' : sender,
  //     'receiver' : receiver,
  //     'message' : 'image__',
  //
  //   });
  //
  //   FirebaseDatabase.instance.ref('Chats').child(receiver).child(sender).child(key).set({
  //     'sender' : sender,
  //     'receiver' : receiver,
  //     'message' : 'image__',
  //
  //   });
  //
  //
  //   var picker=await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if(picker!=null){
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     var sref = storage.ref('${DateTime.now().microsecondsSinceEpoch}.jpeg');
  //     var uploadtask = sref.putFile(File(picker.path));
  //     await Future.value(uploadtask).then(
  //             (v) async {
  //           sref.getDownloadURL().then((url) {
  //             String time = DateFormat('h:mm:a').format(DateTime.now());
  //             FirebaseDatabase.instance.ref('Chats').child(sender).child(receiver).child(key).set({
  //               'sender' : sender,
  //               'receiver' : receiver,
  //               'message' : 'image__',
  //               'time' : time,
  //               'url' : url
  //             });
  //
  //             FirebaseDatabase.instance.ref('Chats').child(receiver).child(sender).child(key).set({
  //               'sender' : sender,
  //               'receiver' : receiver,
  //               'message' : 'image__',
  //               'time' : time,
  //               'url' : url
  //             });
  //           });
  //   });
  // }}

  static Future<void> sendImage(String sender, String receiver) async {
    String key = DateTime.now().microsecondsSinceEpoch.toString();

    // Send the message to Firebase without uploading an image
    FirebaseDatabase.instance.ref('Chats').child(sender).child(receiver).child(key).set({
      'sender': sender,
      'receiver': receiver,
      'message': 'image__',  // This could be a placeholder for an image message
    });

    FirebaseDatabase.instance.ref('Chats').child(receiver).child(sender).child(key).set({
      'sender': sender,
      'receiver': receiver,
      'message': 'image__',  // This could be a placeholder for an image message
    });

    // No image upload, just send a message
  }


  static String errorRead(String error) {
    return error.substring(error.indexOf(']') + 1, error.length);
  }
}
