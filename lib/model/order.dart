// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Order> orderFromJson(String str) =>
    List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  int? id;
  int cusId;
  int ownerId;
  int land;
  int price;

  Order({
    required this.id,
    required this.cusId,
    required this.ownerId,
    required this.land,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        cusId: json["cus_id"],
        ownerId: json["owner_id"],
        land: json["land"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cus_id": cusId,
        "owner_id": ownerId,
        "land": land,
        "price": price,
      };
}
