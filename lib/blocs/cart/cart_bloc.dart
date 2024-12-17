import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';


import 'package:ecommerce_app/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  late final StreamSubscription profileSubscription;
  final ProfileCubit profileCubit;
  CartBloc({required this.cartRepository, required this.profileCubit})
      : super(CartState.initial()) {
    profileSubscription = profileCubit.stream.listen((profileState) {
      if (profileState.profileStatus == ProfileStatus.loaded) {
        add(CartLoadEvent(userId: profileState.user.id));
      }
      
    });
    on<CartLoadEvent>(_onLoadCart);
  }

  Future<void> _onLoadCart(CartLoadEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final cart = await cartRepository.getCart(userId: event.userId);
      if (cart == null) {
        final newCart = await cartRepository.createCart(userId: event.userId);
        emit(state.copyWith(
            status: CartStatus.loaded,
            cartItems: newCart.items,
            totalPrice: newCart.totalPrice,
            userId: newCart.userId));
      } else {
        emit(state.copyWith(
            status: CartStatus.loaded,
            cartItems: cart.items,
            totalPrice: cart.totalPrice,
            userId: cart.userId));
      }
    } catch (error, stackTrace) {
      print("Error loading cart: $error");
      print("Stack trace: $stackTrace");

      emit(state.copyWith(status: CartStatus.error));
    }
  }

  // Future<void> _onAddItemToCart(CartAddItemEvent event, Emitter<CartState> emit) async {
  //   emit(state.copyWith(status: CartStatus.loading));

  //   try {
  //     final updatedCart = await cartRepository.addItemToCart(event.cartItem, userId: event);
  //     emit(state.copyWith(
  //       status: CartStatus.loaded,
  //       cartItems: updatedCart.items,
  //       totalPrice: updatedCart.totalPrice,
  //       userId: updatedCart.userId,
  //     ));
  //   } catch (error) {
  //     print("Error adding item to cart: $error");
  //     emit(state.copyWith(status: CartStatus.error, errorMessage: 'Failed to add item to cart'));
  //   }
  // }

  // Future<void> _onRemoveItemFromCart(CartRemoveItemEvent event, Emitter<CartState> emit) async {
  //   emit(state.copyWith(status: CartStatus.loading));

  //   try {
  //     final updatedCart = await cartRepository.removeItemFromCart(event.item);
  //     emit(state.copyWith(
  //       status: CartStatus.loaded,
  //       cartItems: updatedCart.items,
  //       totalPrice: updatedCart.totalPrice,
  //       userId: updatedCart.userId,
  //     ));
  //   } catch (error) {
  //     print("Error removing item from cart: $error");
  //     emit(state.copyWith(status: CartStatus.error, errorMessage: 'Failed to remove item from cart'));
  //   }
  // }
}
