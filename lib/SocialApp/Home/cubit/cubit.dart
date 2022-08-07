
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/SocialApp/Home/chats/Chats.dart';
import 'package:socialapp/SocialApp/Home/cubit/state.dart';
import 'package:socialapp/SocialApp/Home/feeds/feeds.dart';
import 'package:socialapp/SocialApp/Home/settings/settings.dart';
import 'package:socialapp/SocialApp/Home/users/users.dart';
import 'package:socialapp/SocialApp/newPost/new_post.dart';
import 'package:socialapp/models/messagemodel.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/social_user_model.dart';
import 'package:socialapp/shared/components/constent.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialBaseInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);


  void removePostImage(){
    PostImage = null;
    emit(SocialRemovePostImagePost());
  }

  void removeWords(){
    PostImage = null;
    emit(SocialRemovePostWordsPost());
  }

  SocialUserModel? userModel;
  int CurrentIndex = 0;

  File? profileImage;
  var picker = ImagePicker();

  File? profileCover;

  void getUserData(){
    emit(SocialBaseLoadingState());
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          //print(value.data());
          userModel = SocialUserModel.fromJson(value.data()!);
          print(uId);
       emit(SocialBaseGetUserSuccessState());
    }).catchError((error){
     // print(error.toString());
      emit(SocialBaseGetUserErrorState(error.toString()));
    });
  }


  List<Widget> screens=[
    Feeds(),
    Chats(),
    NewPostScreen(),
    user(),
    settings(),
  ];

  List<String> titles=[
    'Home',
    'Chat',
    'NewPost',
    'User',
    'Setting',
  ];

  void ChangeBottomIndex(int index){
    if(index==1)
      getUsers();
    if(index==2)
      emit(SocialNewPost());
    else{
      CurrentIndex = index;
      emit(SocialBottomNav());
    }
  }



  Future<void> getProfileImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessPost());
    }else{
      print('No Image Selected');
      emit(SocialProfileImagePickedErrorPost());
    }
  }



  Future<void> getProfileCover() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      profileCover = File(pickedFile.path);
      emit(SocialProfileCoverPickedSuccessPost());
    }else{
      print('No Cover Selected');
      emit(SocialProfileCoverPickedErrorPost());
    }
  }


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUserLoadingUpdatePost());
    firebase_storage.FirebaseStorage.instance
        .ref()  //علشان يدخل جوا
        .child('users/${Uri.file(profileImage!.path) //هايدخل فين وازاي
        .pathSegments.last}')
    .putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((value) {//بيرفع//بيرفع
       // emit(SocialUploadProfileImageSuccessPost());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error){
        emit(SocialUploadProfileImageErrorPost());  //الحاله الاولي في الرفع
      });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorPost());
    });
  }


  void uploadProfileCover({
    required String name,
    required String phone,
    required String bio,
}){
    emit(SocialUserLoadingUpdatePost());
    firebase_storage.FirebaseStorage.instance
        .ref()  //علشان يدخل جوا
        .child('users/${Uri.file(profileCover!.path) //هايدخل فين وازاي
        .pathSegments.last}')
        .putFile(profileCover!).then((value){
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileCoverSuccessPost());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);

      }).catchError((error){
        emit(SocialUploadProfileCoverErrorPost());
      });
    }).catchError((error){
      emit(SocialUploadProfileCoverErrorPost());
    });//بيرفع
  }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }){

      SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        bio:bio,
        email: userModel!.email,
        image: image??userModel!.image,
        cover: cover??userModel!.cover,
        uId: userModel!.uId,
        isEmailVerified: false,

      );
      FirebaseFirestore
          .instance
          .collection('users')
          .doc(uId)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error){
        emit(SocialUserUpdateErrorPost());
      });
  }




  File? PostImage;

  Future<void> getPostImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      PostImage = File(pickedFile.path);
      emit(SocialPostImagePickedSucessPost());
    }else{
      print('No Image Selected');
      emit(SocialPostImagePickedErrorPost());
    }
  }

  void UploadPostImage({

    required String dateTime,

    required String text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()  //علشان يدخل جوا
        .child('posts/${Uri.file(PostImage!.path) //هايدخل فين وازاي
        .pathSegments.last}')
        .putFile(PostImage!).then((value){
      value.ref.getDownloadURL().then((value) {
        print(value);
        CreatPost(dateTime: dateTime, text: text,postImage: value,);
      }).catchError((error){
        emit(SocialCreatePostSuccessState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });//بيرفع
  }



  void CreatPost({

    required String dateTime,
    required String text,
    String? postImage,    // علشان ممكن ارفع صوره او لاء
  }){
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
     name: userModel!.name,
      image:userModel!.image,
      uId:userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore
        .instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> Likes = [];

  void getPost(){
       FirebaseFirestore
           .instance
           .collection('posts')
           .get()
           .then((value){
             value.docs.forEach((element) {
               element
                   .reference
                   .collection('likes')
                   .get().then((value) {
                     Likes.add(value.docs.length);
                 postsId.add(element.id);
                 posts.add(PostModel.fromJson(element.data()));
               })
                   .catchError((error){});

             });
             emit(SocialGetPostUserSuccessState());
       })
           .catchError((error){
             emit(SocialGetPostUserErrorState(error.toString()));
       });
  }

  void LikePost(String? PostId)
  {
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(PostId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    })
        .then((value){
          emit(SocialLikePostUserSuccessState());
    })
        .catchError((error){
          emit(SocialLikePostUserErrorState(error.toString()));
    });

  }


  List<SocialUserModel> users=[];

  void getUsers(){
    if(users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.data()['uId']!=userModel!.uId)
       users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    })
        .catchError((error){
      emit(SocialGetAllUserErrorState(error.toString()));
    });
    }
  }


  void SendMessage({
  required String reciverId,
    required String dateTime,
    required String text,
}){
    MessageModel model= MessageModel(
      text: text,
      senderId: userModel!.uId,
      reciverId: reciverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(reciverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];

  void getMessages({
    required String reciverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(reciverId)
        .collection('messages').orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetPostUserSuccessState());
    });
  }

}