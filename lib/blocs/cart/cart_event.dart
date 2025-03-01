part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddItemEvent extends CartEvent {
  final CartItem cartItem;
  final CartState currentCartState;

  const CartAddItemEvent(
      {required this.cartItem, required this.currentCartState});

  @override
  List<Object> get props => [cartItem, currentCartState];
}

class CartRemoveItemEvent extends CartEvent {
  final String productId;

  const CartRemoveItemEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CartRemoveSellerItemsEvent extends CartEvent {
  final String seller;

  const CartRemoveSellerItemsEvent(this.seller);

  @override
  List<Object> get props => [seller];
}

class CartUpdateItemQuantityEvent extends CartEvent {
  final String productId;
  final int quantity;
  final String selectedSize;

  const CartUpdateItemQuantityEvent({required this.productId, required this.quantity,required this.selectedSize});

  @override
  List<Object> get props => [productId, quantity, selectedSize];
}



class CartClearEvent extends CartEvent {}

class CartLoadEvent extends CartEvent {
  final String userId;

  const CartLoadEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CartApplyDiscountEvent extends CartEvent {
  final String discountCode;

  const CartApplyDiscountEvent(this.discountCode);

  @override
  List<Object> get props => [discountCode];
}

