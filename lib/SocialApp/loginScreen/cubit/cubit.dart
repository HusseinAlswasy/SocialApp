

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialapp/SocialApp/loginScreen/cubit/states.dart';
class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  IconData suffix=  Icons.remove_red_eye_rounded;
  bool isPasswordShow = true;

  void userRegister({
    required String email,
    required String password,

  }) {
    emit(SocialLoginLoadingHomeDataStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessStates(value.user!.uid));
    }).catchError((error){
      emit(SocialLoginErrorStates(error.toString()));
    });

  }

  void ChangePasswordVisibility(){
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow?Icons.remove_red_eye_rounded:Icons.visibility_off_rounded;
    emit(SocialLoginChangePassWordVisibility());
  }


}
