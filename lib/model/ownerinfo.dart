// To parse this JSON data, do
//
//     final ownerinfo = ownerinfoFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Ownerinfo> ownerinfoFromJson(String str) =>
    List<Ownerinfo>.from(json.decode(str).map((x) => Ownerinfo.fromJson(x)));

String ownerinfoToJson(List<Ownerinfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ownerinfo {
  int? id;
  String? name;
  String? username;
  String? adress;
  String? phone;
  int? que;
  int? price;

  Ownerinfo({
    required this.id,
    required this.name,
    required this.username,
    required this.adress,
    required this.phone,
    required this.que,
    required this.price,
  });

  factory Ownerinfo.fromJson(Map<String, dynamic> json) => Ownerinfo(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        adress: json["adress"],
        phone: json["phone"],
        que: json["que"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "adress": adress,
        "phone": phone,
        "que": que,
        "price": price,
      };
}
