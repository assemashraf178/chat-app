import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/network/local/cashed_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isLogin = true;
  bool hiddenPassword = true;
  bool hiddenConfirmPassword = true;

  void changeLogin({bool? login}) {
    if (login != null)
      isLogin = login;
    else
      isLogin = !isLogin;
    emit(ChangeLoginSuccess());
  }

  void changeHiddenPassword() {
    hiddenPassword = !hiddenPassword;
    emit(ChangePasswordHiddenSuccess());
  }

  void changeHiddenConfirmPassword() {
    hiddenConfirmPassword = !hiddenConfirmPassword;
    emit(ChangePasswordConfirmHiddenSuccess());
  }

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
    String image =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
  }) {
    emit(RegisterLoadingState());
    print(email);
    print(password);
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;
      CashedHelper.setData(value: uId, key: 'uId');
      createUser(
        uId: value.user!.uid,
        email: email,
        name: name,
        phone: phone,
        image: image,
        isVerificated: false,
      );
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String image,
    required bool isVerificated,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: image,
      isVerificated: false,
      bio: 'write your bio...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(UserCreateSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      print(error.toString());
      emit(UserCreateErrorState(error.toString()));
    });
  }

  void loginUser({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      CashedHelper.setData(value: uId, key: 'uId');
      print(uId);
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
