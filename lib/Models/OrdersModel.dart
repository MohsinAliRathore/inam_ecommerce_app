// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) => OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  String message;
  List<Datum> data;

  OrdersModel({
    required this.message,
    required this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String userId;
  String total;
  String qty;
  String deliveryFee;
  String address;
  String status;
  DateTime updatedAt;
  DateTime createdAt;
  List<OrderDetail> orderDetails;

  Datum({
    required this.id,
    required this.userId,
    required this.total,
    required this.qty,
    required this.deliveryFee,
    required this.address,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.orderDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    total: json["total"],
    qty: json["qty"],
    deliveryFee: json["delivery_fee"],
    address: json["address"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    orderDetails: List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total": total,
    "qty": qty,
    "delivery_fee": deliveryFee,
    "address": address,
    "status": status,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "order_details": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
  };
}

class OrderDetail {
  int id;
  String orderId;
  String productName;
  String productPrice;
  String productQty;
  String total;
  DateTime updatedAt;
  DateTime createdAt;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.productPrice,
    required this.productQty,
    required this.total,
    required this.updatedAt,
    required this.createdAt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    orderId: json["order_id"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productQty: json["product_qty"],
    total: json["total"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_name": productName,
    "product_price": productPrice,
    "product_qty": productQty,
    "total": total,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
  };
}
