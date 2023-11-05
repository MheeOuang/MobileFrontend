import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractor4you/DATA/cusdata.dart';
import 'package:tractor4you/model/customerinfo.dart';
import 'package:tractor4you/page/second/ownerInfo.dart';
import 'package:http/http.dart' as http;
import '../../model/order.dart';

class ListReserve extends StatefulWidget {
  const ListReserve({Key? key}) : super(key: key);

  @override
  State<ListReserve> createState() => _ListReserveState();
}

class _ListReserveState extends State<ListReserve> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    loadOwnerData();
  }

  void loadOwnerData() async {
    final cusData = Provider.of<Cusdata>(context, listen: false);
    String id =
        cusData.id.toString(); // Assuming cusData.id is not already a String
    orders = await selectOrderData(id);
    setState(() {});
    // print(owners[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 238, 194),
        title: const Text(
          "รายการที่จองไว้",
          style: TextStyle(fontFamily: "Mali"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  height: 120,
                  margin: EdgeInsets.all(10),
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "รหัสการจอง: " + orders[index].id.toString(),
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 20),
                            ),
                            Text(
                              "พื้นที่:  " +
                                  orders[index].land.toString() +
                                  "  ไร่",
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 15),
                            ),
                            Text(
                              "ราคารวม:  " +
                                  orders[index].price.toString() +
                                  "  บาท",
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ชำระเงิน'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("คุณต้องการชำระเงินหรือไม่")
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(onPressed: () {}, child: Text('ชำระเงิน'))
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Order>> selectOrderData(String id) async {
    var response =
        await http.get(Uri.parse("http://10.0.1.132:5000/order/select/" + id));
    List<Order> owners = orderFromJson(response.body);
    // print(students[0].name.toString());
    return owners;
  }
}
