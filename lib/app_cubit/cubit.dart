import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/app_cubit/states.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/about_me/about_me_sreen.dart';
import 'package:chat_app/modules/chats/chats_screen.dart';
import 'package:chat_app/modules/users/users_screen.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState()) {
    messages = [];
    setState();
  }

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel userModel = UserModel();

  List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: Icon(IconBroken.User1),
      title: Text('Users'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white.withOpacity(0.7),
    ),
    SalomonBottomBarItem(
      icon: Icon(IconBroken.Chat),
      title: Text('Chats'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white.withOpacity(0.7),
    ),
    SalomonBottomBarItem(
      icon: Icon(IconBroken.Info_Circle),
      title: Text('About me'),
      selectedColor: Colors.white,
      unselectedColor: Colors.white.withOpacity(0.7),
    ),
  ];

  List<Widget> screens = [
    UsersScreen(),
    ChatsScreen(),
    AboutMeScreen(),
  ];

  List<String> titles = [
    'Users',
    'Chats',
    'About me',
  ];

  int currentIndex = 0;

  void changeNavBottomBarIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBottomBarIndexSuccessState());
  }

  void getData() {
    if (uId != null) {
      emit(GetDataLoadingState());
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .snapshots()
          .listen((event) {
        userModel = UserModel.fromJson(event.data());
        emit(GetDataSuccessState());
      });
    }
  }

  List<UserModel> users = [];

  void getUsers() {
    emit(GetUsersLoadingState());
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (uId != element.data()['uId'])
          users.add(UserModel.fromJson(element.data()));
        emit(GetUsersSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetUsersErrorState());
    });
  }

  ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  Future<void> getImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      emit(PickedImageSuccessState());
    } else {
      print('Not found any image');
      emit(PickedImageErrorState());
    }
  }

  String? imageUploaded;

  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$uId/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(imageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUploaded = value;
        print(value);
        imageFile = null;
        emit(UploadImageSuccessState());
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void updateUserData({
    required String email,
    required String phone,
    required String name,
    required String bio,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: imageUploaded ?? userModel.image,
      isVerificated: FirebaseAuth.instance.currentUser!.emailVerified,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getData();
      print(name);
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  void sendMessage({
    required String text,
    required String receiverUid,
    required String userImage,
  }) {
    emit(SendMessageLoadingState());
    var messageModel = MessageModel(
      text: text,
      dateTime: DateTime.now().toString(),
      receiverUid: receiverUid,
      senderUid: userModel.uId,
      image: userModel.image,
      userImage: userImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverUid)
          .set({
        'inChat': true,
        'receiverUid': receiverUid,
      });
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(userModel.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverUid)
          .collection('chats')
          .doc(uId)
          .set({
        'inChat': true,
        'receiverUid': userModel.uId,
      });
      emit(SendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverUid,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }

  List<UserModel> chats = [];

  void getChats() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        print(element.data());
        print(element['receiverUid']);
        chats = [];
        if (element['inChat'] == true) {
          getUserChat(
            id: element['receiverUid'],
          );
        }
      });
      print(chats);
    });
  }

  void getUserChat({required String id}) {
    emit(GetDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(id.trim())
        .get()
        .then((event) {
      print(id.trim());
      print(event.data());
      chats.add(UserModel.fromJson(event.data()));
      emit(GetDataSuccessState());
    });
  }

  void setState() {
    emit(TestState());
  }
}
