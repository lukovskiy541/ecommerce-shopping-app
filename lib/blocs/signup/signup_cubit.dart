import 'package:ecommerce_app/models/custom_error.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;
  SignupCubit({required this.authRepository}) : super(SignupState.initial());

  Future<void> signup({required String email, required String password}) async {
    emit(state.copyWith(signinStatus: SignupStatus.submiting));

    try {
      await authRepository.signin(email: email, password: password);
      emit(state.copyWith(signinStatus: SignupStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signinStatus: SignupStatus.error, error: e));
    }
  }
  void resetErrorState() {
  emit(state.copyWith(
    signinStatus: SignupStatus.initial,
    error: null,
  ));
}

}