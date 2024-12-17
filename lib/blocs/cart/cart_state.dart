// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItem> cartItems;
  double totalPrice;
  final String userId;

  CartState(
      {required this.status,
      required this.cartItems,
      required this.totalPrice,
      required this.userId});

  factory CartState.initial() {
    return CartState(
      status: CartStatus.initial,
      cartItems: [],
      totalPrice: 0,
      userId: '',
    );
  }

  @override
  List<Object> get props => [status, cartItems, totalPrice, userId];

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    double? totalPrice,
    String? userId,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
    );
  }
}
