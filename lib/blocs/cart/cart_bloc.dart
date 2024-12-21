import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/models/cart_item_model.dart';
import 'package:ecommerce_app/models/cart_model.dart';

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
      print('ProfileCubit state: $profileState');
      if (profileState.profileStatus == ProfileStatus.loaded) {
        add(CartLoadEvent(userId: profileState.user.id));
      }
      if (profileState.profileStatus == ProfileStatus.initial) {
        add(CartClearEvent());
      }
    });
    on<CartLoadEvent>(_onLoadCart);
    on<CartAddItemEvent>(_onAddItemToCart);
    on<CartRemoveSellerItemsEvent>(_onRemoveSellerItemsEvent);
    on<CartUpdateItemQuantityEvent>(_onUpdateQuanity);
    on<CartClearEvent>((event, emit) {
      emit(CartState.initial());
    });
  }

  Future<void> _onUpdateQuanity(
      CartUpdateItemQuantityEvent event, Emitter<CartState> emit) async {
    try {
      final updatedItems = state.cart.items.map((item) {
        if (item.product.id == event.productId &&
            item.selectedSize == event.selectedSize) {
          return item.copyWith(quantity: item.quantity + event.quantity);
        }
        return item;
      }).toList();
      final updatedCart = await cartRepository.updateCartItems(
          currentCart: state, updatedItems: updatedItems);
      emit(state.copyWith(
          cart: state.cart.copyWith(items: updatedItems),
          totalPrice: updatedCart.totalPrice,
          status: CartStatus.loaded));
    } catch (error, stackTrace) {
      print("Error loading cart: $error");
      print("Stack trace: $stackTrace");

      emit(state.copyWith(status: CartStatus.error));
    }
  }

  Future<void> _onLoadCart(CartLoadEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final cart = await cartRepository.getCart(userId: event.userId);

      emit(state.copyWith(
          status: CartStatus.loaded,
          cart: cart,
          totalPrice: cart.totalPrice,
          userId: cart.userId));
    } catch (error, stackTrace) {
      print("Error loading cart: $error");
      print("Stack trace: $stackTrace");

      emit(state.copyWith(status: CartStatus.error));
    }
  }

  Future<void> _onAddItemToCart(
      CartAddItemEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    if (state.status != CartStatus.loaded) {
      try {
        await cartRepository.getCart(userId: state.userId);
      } catch (error) {
        emit(state.copyWith(
          status: CartStatus.error,
        ));
        return;
      }
    }
    try {
      final updatedCart = await cartRepository.addItemToCart(
          cartItem: event.cartItem, currentCart: event.currentCartState);
      emit(state.copyWith(
        status: CartStatus.loaded,
        cart: updatedCart,
        totalPrice: updatedCart.totalPrice,
        userId: updatedCart.userId,
      ));
    } catch (error) {
      print("Error adding item to cart: $error");
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  Future<void> _onRemoveSellerItemsEvent(
      CartRemoveSellerItemsEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final updatedItems = state.cart.items
          .where((item) => item.product.seller != event.seller)
          .toList();

      final updatedCart = await cartRepository.updateCartItems(
          currentCart: state, updatedItems: updatedItems);

      emit(state.copyWith(
        status: CartStatus.loaded,
        cart: updatedCart,
        totalPrice: updatedCart.totalPrice,
        userId: updatedCart.userId,
      ));
    } catch (error) {
      print("Error removing item from cart: $error");
      emit(state.copyWith(status: CartStatus.error));
    }
  }
}
