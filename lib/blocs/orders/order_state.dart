// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'order_bloc.dart';

enum OrdersStatus {
  initial,
  loading,
  loaded,
  error,
}

class OrderState extends Equatable {
  final List<Order> orders;
  final OrdersStatus status;
  const OrderState({required this.orders, required this.status});

  factory OrderState.initial() {
    return OrderState(orders: [], status: OrdersStatus.initial);
  }

  
  @override
  List<Object> get props => [orders, status];

  OrderState copyWith({
    List<Order>? orders,
    OrdersStatus? status,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      status: status ?? this.status,
    );
  }
}


