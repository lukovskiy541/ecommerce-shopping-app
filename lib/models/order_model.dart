import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.items,
    required this.deliveryAdress,
    required this.paymentInfo,
    required this.createdAt,
    required this.subtotal,
    required this.deliveryCost,
    required this.discount,
    required this.bonusesUsed,
    required this.bonusesEarned,
    required this.total,
    required this.isGift,
    this.confirmedAt,
    this.processedAt,
    this.shippedAt,
    this.deliveredAt,
    this.cancelledAt,
    this.promoCode,
    this.customerNote,
    this.adminNote,
    this.giftMessage
  });
  final String id;
  final String userId;
  final OrderStatus status;
  final List<dynamic> items;
  final String deliveryAdress;
  final PaymentInfo paymentInfo;
  
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? processedAt;
  final DateTime? shippedAt;
  final DateTime? deliveredAt;
  final DateTime? cancelledAt;
  
  final double subtotal;
  final double deliveryCost;
  final double discount;
  final int bonusesUsed;
  final int bonusesEarned;
  final double total;
  
  final String? promoCode;
  final String? customerNote;
  final String? adminNote;
  final bool isGift;
  final String? giftMessage;

   factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${map['status'] ?? 'pending'}',
        orElse: () => OrderStatus.pending,
      ),
      items: (map['items'] as List<dynamic>?)
          ?.map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
          .toList() ?? [],
      deliveryAdress: map['deliveryAdress'] ?? '',
      paymentInfo: PaymentInfo.fromMap(
        map['paymentInfo'] as Map<String, dynamic>? ?? {},
      ),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      confirmedAt: (map['confirmedAt'] as Timestamp?)?.toDate(),
      processedAt: (map['processedAt'] as Timestamp?)?.toDate(),
      shippedAt: (map['shippedAt'] as Timestamp?)?.toDate(),
      deliveredAt: (map['deliveredAt'] as Timestamp?)?.toDate(),
      cancelledAt: (map['cancelledAt'] as Timestamp?)?.toDate(),
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      deliveryCost: (map['deliveryCost'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      bonusesUsed: map['bonusesUsed'] ?? 0,
      bonusesEarned: map['bonusesEarned'] ?? 0,
      total: (map['total'] ?? 0).toDouble(),
      promoCode: map['promoCode'],
      customerNote: map['customerNote'],
      adminNote: map['adminNote'],
      isGift: map['isGift'] ?? false,
      giftMessage: map['giftMessage'],
    );
  }
}

class OrderItem {
  OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.size,
    required this.color,
    required this.sku,
    required this.quantity,
    required this.price,
    required this.total,
    required this.canBeReturned,
    this.note,
    this.returnDeadline
  });
  final String id;
  final String productId;
  final String productName;
  final String size;
  final String color;
  final String sku;
  final int quantity;
  final double price;
  final double total;
  final String? note;
  final bool canBeReturned;
  final DateTime? returnDeadline;
   factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      size: map['size'] ?? '',
      color: map['color'] ?? '',
      sku: map['sku'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      note: map['note'],
      canBeReturned: map['canBeReturned'] ?? false,
      returnDeadline: (map['returnDeadline'] as Timestamp?)?.toDate(),
    );
  }
}



class PaymentInfo {
  PaymentInfo({
    required this.method,
    required this.status,
    required this.requiresPrepayment,
    this.transactionId,
    this.paidAt,
    this.receiptUrl
  });
  final PaymentMethod method;
  final PaymentStatus status;
  final String? transactionId;
  final DateTime? paidAt;
  final String? receiptUrl;
  final bool requiresPrepayment;
  factory PaymentInfo.fromMap(Map<String, dynamic> map) {
    return PaymentInfo(
      method: PaymentMethod.values.firstWhere(
        (e) => e.toString() == 'PaymentMethod.${map['method'] ?? 'card'}',
        orElse: () => PaymentMethod.card,
      ),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.${map['status'] ?? 'pending'}',
        orElse: () => PaymentStatus.pending,
      ),
      transactionId: map['transactionId'],
      paidAt: (map['paidAt'] as Timestamp?)?.toDate(),
      receiptUrl: map['receiptUrl'],
      requiresPrepayment: map['requiresPrepayment'] ?? false,
    );
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  readyToShip,
  shipped,
  delivered,
  completed,
  cancelled,
  returned
}

enum PaymentMethod {
  card,
  cash,
  applePay,
  googlePay,
  bankTransfer
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded
}

enum DeliveryType {
  novaPoshta,
  courier,
  storePickup
}
