// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Customer> customerFromJson(String str) =>
    List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  int? id;
  String? username;
  String? password;
  String? phone;
  String? name;
  String? address;

  Customer({
    required this.id,
    required this.username,
    required this.password,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        phone: json["phone"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "phone": phone,
        "name": name,
        "address": address,
      };
}
