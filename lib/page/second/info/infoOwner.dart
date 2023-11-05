// ignore_for_file: deprecated_member_use, camel_case_types, unused_element

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tractor4you/model/order.dart';
import 'package:tractor4you/model/ownerinfo.dart';
import 'package:tractor4you/page/second/Home.dart';
import 'package:http/http.dart' as http;

import '../../../DATA/cusdata.dart';
// import 'package:url_launcher/url_launcher.dart';

class infoOwner extends StatefulWidget {
  Ownerinfo ownerinfo;
  infoOwner({Key? mykey, required this.ownerinfo}) : super(key: mykey);

  @override
  State<infoOwner> createState() => _infoOwnerState();
}

class _infoOwnerState extends State<infoOwner> {
  final land = TextEditingController();
  late int cusid_int;

  @override
  void initState() {
    super.initState();
    loadOwnerData();
  }

  void loadOwnerData() async {
    final cusData = Provider.of<Cusdata>(context, listen: false);
    cusid_int = cusData.id; // Assuming cusData.id is not already a String
    setState(() {});
    // print(owners[0].name);
  }

  void _showDialogReserve(BuildContext context, Ownerinfo ownerinfo) {
    Ownerinfo ownerinfo = widget.ownerinfo;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, cusdata, child) => AlertDialog(
            title: const Text(
              "การจองคิว",
              style: TextStyle(fontFamily: "Mali"),
            ),
            content: const Text('ต้องการจองหรือไม่',
                style: TextStyle(fontFamily: "Mali")),
            actions: <Widget>[
              const SizedBox(height: 5),
              TextFormField(
                controller: land,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: "พื้นที่กี่ไร่",
                  labelStyle: const TextStyle(fontSize: 12, fontFamily: "Mali"),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    var data = {"id": ownerinfo.id};
                    Ownerinfo ownerid = Ownerinfo.fromJson(data);
                    updateQ(ownerid);

                    int iLand = int.parse(land.text);
                    int? price = ownerinfo.price;

                    var data2 = {
                      "cus_id": this.cusid_int,
                      "owner_id": ownerinfo.id,
                      "land": iLand,
                      "price": ownerinfo.price
                    };
                    Order order = Order.fromJson(data2);
                    createOrder(order);
                    setState(() {});
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('จองเรียบร้อย'),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text("ยินดีตอนรับเข้าสู่ระบบ")
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Home(); // Navigate to the Home widget
                                      },
                                    ),
                                  );
                                },
                                child: Text('ตกลง'))
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("ยืนยัน")],
                  )),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("ยกเลิก")],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Ownerinfo ownerinfo = widget.ownerinfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "รายละเอียด",
          style: TextStyle(fontFamily: "Mali"),
        ),
      ),
      body: Consumer(
        builder: (context, cusdata, child) => SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 0, 0,
                        0), // Set the background color for the circle
                    radius: 50,
                    child: Icon(
                      Icons.person, // Example icon (you can use any icon)
                      size: 50, // Adjust the icon size
                      color: Colors.white, // Set the icon color
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ownerinfo.name.toString(),
                    style: TextStyle(fontFamily: "Mali", fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 10)),
                      onPressed: () async {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            ownerinfo.phone.toString(),
                            style: TextStyle(
                                fontFamily: "Mali", color: Colors.black),
                          ),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 10)),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "จำนวนคิว " + ownerinfo.que.toString() + " คิว",
                            style: TextStyle(
                                fontFamily: "Mali", color: Colors.black),
                          )
                        ],
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(200, 10)),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 144, 238, 145),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color.fromARGB(
                              255,
                              0,
                              0,
                              0,
                            ), // Set the border color here
                            width: 2.0, // Set the border width
                          ),
                        ),
                      ),
                      onPressed: () {
                        // print(ownerinfo.name);

                        _showDialogReserve(context, ownerinfo);
                      },
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "จองคิว",
                              style: TextStyle(
                                  fontFamily: "Mali", color: Colors.black),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateQ(Ownerinfo customer) async {
    var response = await http.post(
        Uri.parse("http://10.0.1.132:5000/owner/updateQ"),
        body: jsonEncode(customer),
        headers: {"Content-Type": "application/json"});
    print(response.body);
  }

  Future<void> createOrder(Order order) async {
    var response = await http.post(
        Uri.parse("http://10.0.1.132:5000/order/create"),
        body: jsonEncode(order),
        headers: {"Content-Type": "application/json"});
    print(response.body);
  }
}
