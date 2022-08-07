
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/SocialApp/SingUp/cubit/states.dart';
import 'package:socialapp/models/social_user_model.dart';

class SocialSignUpCubit extends Cubit<SocialSignUpStates> {
  SocialSignUpCubit() : super(SocialSignUpInitialState());

  static SocialSignUpCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,

  }) {
    emit(SocialSignUpLoadingHomeDataStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,

    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreateUser(name: name, email: email, phone: phone, uId: value.user!.uid);
      emit(SocialSignUpSuccessState());
    }).catchError((error) {
      emit(SocialErrorStates(error.toString()));
    });
  }

  void CreateUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio:'Write your bio .....',
      image: 'https://img.freepik.com/free-photo/indoor-photo-satisfied-teenage-girl-texts-cellular-reads-interesting-article-online-wears-casual-outfit-creats-new-publication-own-web-page-isolated-brown-wall-with-free-space_273609-26359.jpg?t=st=1658360328~exp=1658360928~hmac=09615fec24f098d8fb3e0773a8b0e96d2fdb7853224d70d26eec0db4f16f535a&w=740',
      cover: 'https://as1.ftcdn.net/v2/jpg/04/40/29/94/1000_F_440299419_s4b12RfNDJvpplheVDmKdhFGJiHlAYNs.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')  //بيبدأ ينشا هناك لو مفيش
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccessState());
    })
        .catchError((error) {
          emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_rounded;
  bool isPasswordShow = true;

  void ChangePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.remove_red_eye_rounded
        : Icons.visibility_off_rounded;
    emit(SocialSignUpChangePassWordVisibility());
  }
}
