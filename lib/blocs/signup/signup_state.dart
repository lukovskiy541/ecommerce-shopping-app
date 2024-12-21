
part of '../signin/signup_cubit.dart';

enum SignupStatus { initial, submiting, success, error }

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError error;
  SignupState({
    required this.signupStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
        signupStatus: SignupStatus.initial, error: CustomError());
  }

  @override
  List<Object> get props => [signupStatus, error];

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
