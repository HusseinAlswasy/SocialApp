
abstract class SocialLoginStates{}

class  SocialLoginInitialState extends SocialLoginStates{}

class  SocialLoginLoadingHomeDataStates extends SocialLoginStates{}

class  SocialLoginSuccessStates extends SocialLoginStates{
  final String? uId;

  SocialLoginSuccessStates(this.uId);
}


class  SocialLoginErrorStates extends SocialLoginStates{
  final String error;

  SocialLoginErrorStates(this.error);
}


class  SocialLoginChangePassWordVisibility extends SocialLoginStates{}