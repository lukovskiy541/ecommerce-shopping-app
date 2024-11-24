import 'package:ecommerce_app/models/custom_error.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(SignupState.initial());

 Future<void> signup({required String email, required String password}) async {
  emit(state.copyWith(signupStatus: SignupStatus.submiting));  // Fixed

  try {
    await authRepository.signup(email: email, password: password);
    emit(state.copyWith(signupStatus: SignupStatus.success));  // Fixed
  } on CustomError catch (e) {
    emit(state.copyWith(signupStatus: SignupStatus.error, error: e));  // Fixed
  }
}
  void resetErrorState() {
  emit(state.copyWith(
    signupStatus: SignupStatus.initial,
    error: null,
  ));
}

}