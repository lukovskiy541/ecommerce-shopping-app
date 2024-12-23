import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';

import 'package:ecommerce_app/models/order_model.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';


part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  final ProfileCubit profileCubit;
  late final StreamSubscription profileSubscription;

  OrderBloc({
    required this.orderRepository,
    required this.profileCubit,
  }) : super(OrderState.initial()) {
     on<OrdersLoadEvent>(_onLoadOrders);
    on<AddOrderEvent>(_onAddOrder);
    on<OrdersClearEvent>((event, emit) => emit(OrderState.initial()));
     if (profileCubit.state.profileStatus == ProfileStatus.loaded) {
      print("Initial state loaded - adding OrdersLoadEvent");
    add(OrdersLoadEvent(userId: profileCubit.state.user.id));
  }
    profileSubscription = profileCubit.stream.listen((profileState) {
      
      if (profileState.profileStatus == ProfileStatus.loaded) {
    
        add(OrdersLoadEvent(userId: profileState.user.id));
      }
      if (profileState.profileStatus == ProfileStatus.initial) {
        add(OrdersClearEvent());
      }
    });

   
  }

 Future<void> _onAddOrder(AddOrderEvent event, Emitter<OrderState> emit) async {
  emit(state.copyWith(status: OrdersStatus.loading));

  try {
    await orderRepository.createOrder(order: event.order);
    emit(state.copyWith(status: OrdersStatus.loaded));
    event.completer.complete(true);
  } catch (e) {
    emit(state.copyWith(status: OrdersStatus.error));
    event.completer.complete(false);
  }
}

  Future<void> _onLoadOrders(
      OrdersLoadEvent event, Emitter<OrderState> emit) async {
    emit(OrderState(orders: [], status: OrdersStatus.loading));
    try {
      final orders = await orderRepository.getOrders(userId: event.userId);
      emit(OrderState(orders: orders, status: OrdersStatus.loaded));
    } catch (error) {
      emit(OrderState(orders: [], status: OrdersStatus.error));
    }
  }

  @override
  Future<void> close() {
    profileSubscription.cancel();
    return super.close();
  }
}
