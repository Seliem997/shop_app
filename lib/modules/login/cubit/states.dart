abstract class LoginStates{}

class LogInitialState extends LoginStates {}

class LogLoadingState extends LoginStates {}

class LogSuccessState extends LoginStates {}

class LogErrorState extends LoginStates {
  final String error;

  LogErrorState(this.error);
}