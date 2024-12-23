part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrdersLoadEvent extends OrderEvent {
  final String userId;
  OrdersLoadEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class OrdersClearEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class AddOrderEvent extends OrderEvent {
  final Order order;
  final Completer<bool> completer;
  AddOrderEvent({required this.order, required this.completer});
  @override
  List<Object> get props => [order, completer];
}
