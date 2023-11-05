// To parse this JSON data, do
//
//     final customerinfo = customerinfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Customerinfo> customerinfoFromJson(String str) => List<Customerinfo>.from(
    json.decode(str).map((x) => Customerinfo.fromJson(x)));

String customerinfoToJson(List<Customerinfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customerinfo {
  int id;
  String username;
  String phone;
  String name;
  String address;

  Customerinfo({
    required this.id,
    required this.username,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory Customerinfo.fromJson(Map<String, dynamic> json) => Customerinfo(
        id: json["id"],
        username: json["username"],
        phone: json["phone"],
        name: json["name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone": phone,
        "name": name,
        "address": address,
      };
}
