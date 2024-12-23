import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });
    on<AuthStateChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(state.copyWith(
            authStatus: AuthStatus.authenticated, user: event.user));
      } else {
        emit(
            state.copyWith(authStatus: AuthStatus.unauthenticated, user: null));
      }
    });

    on<DeleteAccountRequestedEvent>((event, emit) async {
      if (state.authStatus == AuthStatus.authenticated && state.user != null) {
        try {
          await authRepository.deleteUserData(uid: state.user!.uid);

          await authRepository.deleteAccount();

          emit(state.copyWith(
              authStatus: AuthStatus.unauthenticated, user: null));
        } catch (e) {
          print('Помилка видалення акаунту: $e');
        }
      }
    });

    on<SignOutRequestedEvent>((event, emit) async {
      await authRepository.signout();
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated, user: null));
    });
  }
}
