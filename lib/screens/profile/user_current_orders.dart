import 'package:ecommerce_app/blocs/orders/order_bloc.dart';
import 'package:ecommerce_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrders extends StatefulWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мої замовлення'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.status == OrdersStatus.loading || state.status == OrdersStatus.initial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == OrdersStatus.error) {
            return Center(
              child: Text('Помилка завантаження замовлень'),
            );
          }

          final orders = state.orders;
          
          if (orders.isEmpty) {
            return Center(
              child: Text('У вас поки немає замовлень'),
            );
          }

          final ordersPending = orders.where((order) => 
            order.status == OrderStatus.pending).toList();
          final ordersCompleted = orders.where((order) => 
            order.status == OrderStatus.completed).toList();
          final ordersCancelled = orders.where((order) => 
            order.status == OrderStatus.cancelled).toList();
          final ordersReturned = orders.where((order) => 
            order.status == OrderStatus.returned).toList();

          return ListView(
            children: [
              if (ordersPending.isNotEmpty)
                ExpansionTile(
                  title: Text('В обробці (${ordersPending.length})'),
                  children: ordersPending
                      .map((order) => OrderListTile(order: order))
                      .toList(),
                ),
              if (ordersCompleted.isNotEmpty)
                ExpansionTile(
                  title: Text('Виконані (${ordersCompleted.length})'),
                  children: ordersCompleted
                      .map((order) => OrderListTile(order: order))
                      .toList(),
                ),
              if (ordersCancelled.isNotEmpty)
                ExpansionTile(
                  title: Text('Скасовані (${ordersCancelled.length})'),
                  children: ordersCancelled
                      .map((order) => OrderListTile(order: order))
                      .toList(),
                ),
              if (ordersReturned.isNotEmpty)
                ExpansionTile(
                  title: Text('Повернуті (${ordersReturned.length})'),
                  children: ordersReturned
                      .map((order) => OrderListTile(order: order))
                      .toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}

class OrderListTile extends StatelessWidget {
  final Order order;

  const OrderListTile({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Замовлення #${order.createdAt}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Сума: \$${order.total}'),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
