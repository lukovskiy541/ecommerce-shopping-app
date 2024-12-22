import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../../models/custom_error.dart';
import '../../models/user_model.dart';
import '../../repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  late final StreamSubscription authSubscription;
  final AuthRepository authRepository;
  final OrderRepository orderRepository;
  ProfileCubit({
    required this.profileRepository,
    required this.authRepository,
    required this.orderRepository,
  }) : super(ProfileState.initial()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      if (user == null) {
        emit(state.copyWith(user: null, profileStatus: ProfileStatus.initial));
      } else {
        getProfile(uid: user.uid);
      }
    });
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }

  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final User user = await profileRepository.getProfile(uid: uid);
      emit(state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: user,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
    }
  }

  

  Future<void> updateProfile({required User user}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final updatedUser = await profileRepository.updateProfile(user: user);
      emit(state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: updatedUser,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
    }
  }

  Future<void> toggleFavorite({required Product product}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final updatedUser = await profileRepository.toggleFavoriteProduct(
        user: state.user,
        product: product,
      );

      emit(state.copyWith(
        profileStatus: ProfileStatus.loaded,
        user: updatedUser,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
    }
  }

  Future<bool> addOrder({required Order order}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      await orderRepository.createOrder(
        order: order,
      );

      emit(state.copyWith(
        profileStatus: ProfileStatus.loaded,
      ));
      return true;
    } on CustomError catch (e) {
      emit(state.copyWith(
        profileStatus: ProfileStatus.error,
        error: e,
      ));
      return false;
    }
  }

  void clearFavorites() {
    profileRepository.clearfavorites(user: state.user);
    emit(state.copyWith(
      user: state.user.copyWith(favoriteProducts: []),
    ));
  }
}
