import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
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
  ProfileCubit({
    required this.profileRepository,
    required this.authRepository,
  }) : super(ProfileState.initial()) {
    authSubscription = authRepository.user.listen((fbAuth.User? user) {
      getProfile(uid: user!.uid);
    });
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

  Future<void> addFavorite({required Product product}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));

    try {
      final updatedUser = await profileRepository.addFavoriteProduct(
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
}
