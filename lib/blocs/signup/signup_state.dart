
part of 'signup_cubit.dart';

enum SignupStatus { initial, submiting, success, error }

class SignupState extends Equatable {
  final SignupStatus signinStatus;
  final CustomError error;
  SignupState({
    required this.signinStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
        signinStatus: SignupStatus.initial, error: CustomError());
  }

  @override
  List<Object> get props => [signinStatus, error];

  SignupState copyWith({
    SignupStatus? signinStatus,
    CustomError? error,
  }) {
    return SignupState(
      signinStatus: signinStatus ?? this.signinStatus,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}