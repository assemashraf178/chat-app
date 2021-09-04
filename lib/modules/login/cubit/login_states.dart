abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class ChangeLoginSuccess extends LoginStates {}

class ChangePasswordHiddenSuccess extends LoginStates {}

class ChangePasswordConfirmHiddenSuccess extends LoginStates {}

class RegisterLoadingState extends LoginStates {}

class RegisterSuccessState extends LoginStates {}

class RegisterErrorState extends LoginStates {
  final String error;

  RegisterErrorState(this.error);
}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class UserCreateLoadingState extends LoginStates {}

class UserCreateSuccessState extends LoginStates {
  final String uId;

  UserCreateSuccessState(this.uId);
}

class UserCreateErrorState extends LoginStates {
  final String error;

  UserCreateErrorState(this.error);
}
