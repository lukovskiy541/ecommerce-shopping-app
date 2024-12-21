import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/order_model.dart' as Order;

class OrderRepository {
  final FirebaseFirestore firebaseFirestore;

  OrderRepository({required this.firebaseFirestore});

  Future<Order.Order> createOrder({
    required Order.Order order,
  }) async {
    try {
      final orderRef = firebaseFirestore.collection('orders').doc();
      final orderData = {
        'userId': order.userId,
        'status': order.status.toString().split('.').last,
        'items': order.items.map((item) => item.toMap()).toList(),
        'deliveryAdress': order.deliveryAdress,
        'createdAt': FieldValue.serverTimestamp(),
        'confirmedAt': order.confirmedAt,
        'processedAt': order.processedAt,
        'shippedAt': order.shippedAt,
        'deliveredAt': order.deliveredAt,
        'cancelledAt': order.cancelledAt,
        'subtotal': order.subtotal,
        'deliveryCost': order.deliveryCost,
        'discount': order.discount,
        'bonusesUsed': order.bonusesUsed,
        'bonusesEarned': order.bonusesEarned,
        'total': order.total,
        'promoCode': order.promoCode,
        'customerNote': order.customerNote,
        'adminNote': order.adminNote,
        'isGift': order.isGift,
        'giftMessage': order.giftMessage,
      };

      await orderRef.set(orderData);

      return Order.Order(
        id: orderRef.id,
        userId: order.userId,
        status: order.status,
        items: order.items,
        deliveryAdress: order.deliveryAdress,
        createdAt: DateTime.now(),
        confirmedAt: order.confirmedAt,
        processedAt: order.processedAt,
        shippedAt: order.shippedAt,
        deliveredAt: order.deliveredAt,
        cancelledAt: order.cancelledAt,
        subtotal: order.subtotal,
        deliveryCost: order.deliveryCost,
        discount: order.discount,
        bonusesUsed: order.bonusesUsed,
        bonusesEarned: order.bonusesEarned,
        total: order.total,
        promoCode: order.promoCode,
        customerNote: order.customerNote,
        adminNote: order.adminNote,
        isGift: order.isGift,
        giftMessage: order.giftMessage,
      );
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }
}
