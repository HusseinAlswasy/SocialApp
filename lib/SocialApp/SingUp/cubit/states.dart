
abstract class SocialSignUpStates{}

class  SocialSignUpInitialState extends SocialSignUpStates{}

class  SocialSignUpLoadingHomeDataStates extends SocialSignUpStates{}

class  SocialSignUpSuccessState extends SocialSignUpStates{}

class  SocialErrorStates extends SocialSignUpStates{
  final String error;

  SocialErrorStates(this.error);
}
class  SocialCreateUserSuccessState extends SocialSignUpStates{}

class  SocialCreateUserErrorStates extends SocialSignUpStates{
  final String error;

  SocialCreateUserErrorStates(this.error);
}


class  SocialSignUpChangePassWordVisibility extends SocialSignUpStates{}