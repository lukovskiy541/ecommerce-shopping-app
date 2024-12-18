// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, error }

// ignore: must_be_immutable
class CartState extends Equatable {
  final CartStatus status;
  final Cart cart;
  double totalPrice;
  final String userId;

  CartState(
      {required this.status,
      required this.cart,
      required this.totalPrice,
      required this.userId});

  factory CartState.initial() {
    return CartState(
      status: CartStatus.initial,
      cart: Cart.initial(''),
      totalPrice: 0,
      userId: '',
    );
  }

  @override
  List<Object> get props => [status, cart, totalPrice, userId];

  CartState copyWith({
    CartStatus? status,
    Cart? cart,
    double? totalPrice,
    String? userId,
  }) {
    return CartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
    );
  }
}
