abstract class LoginMainState {}

class LoginMainInitialState extends LoginMainState{}
class LoginLoadingState extends LoginMainState{}
class LoginSuccessState extends LoginMainState{}

class LoginErrorState extends LoginMainState{
  final  error;

  LoginErrorState(this.error);
}
