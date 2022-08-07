
abstract class SocialStates {}

class SocialBaseInitialState extends SocialStates{}

class SocialBaseLoadingState extends SocialStates{}

class SocialBaseGetUserSuccessState extends SocialStates{}

class SocialBaseGetUserErrorState extends SocialStates{
  final String Error;

  SocialBaseGetUserErrorState(this.Error);
}


class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostUserSuccessState extends SocialStates{}

class SocialGetPostUserErrorState extends SocialStates{
  final String Error;

  SocialGetPostUserErrorState(this.Error);
}


class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String Error;

  SocialGetAllUserErrorState(this.Error);
}



class SocialLikePostUserSuccessState extends SocialStates{}

class SocialLikePostUserErrorState extends SocialStates{
  final String Error;

  SocialLikePostUserErrorState(this.Error);
}


class SocialBottomNav extends SocialStates{}

class SocialNewPost extends SocialStates{}

class SocialProfileImagePickedSuccessPost extends SocialStates{}
class SocialProfileImagePickedErrorPost extends SocialStates{}

class SocialProfileCoverPickedSuccessPost extends SocialStates{}
class SocialProfileCoverPickedErrorPost extends SocialStates{}

class SocialUploadProfileImageSuccessPost extends SocialStates{}
class SocialUploadProfileImageErrorPost extends SocialStates{}

class SocialUploadProfileCoverSuccessPost extends SocialStates{}
class SocialUploadProfileCoverErrorPost extends SocialStates{}

class SocialUserUpdateErrorPost extends SocialStates{}

class SocialUserLoadingUpdatePost extends SocialStates{}


// create post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSucessPost extends SocialStates{}
class SocialPostImagePickedErrorPost extends SocialStates{}
class SocialRemovePostImagePost extends SocialStates{}
class SocialRemovePostWordsPost extends SocialStates{}


class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{}