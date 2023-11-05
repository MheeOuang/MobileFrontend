import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractor4you/DATA/cusdata.dart';
import 'package:tractor4you/model/customerinfo.dart';
import 'package:tractor4you/page/bottom/ListOfOwner.dart';
import 'package:tractor4you/page/fist/Member.dart';
import 'package:tractor4you/page/second/Home.dart';
import 'package:http/http.dart' as http;

import '../../model/customer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> fromkey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  List<Customerinfo> cusinfo = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<Cusdata>(
      builder: (context, cusdata, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: fromkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
                  const Text(
                    "เข้าสู่ระบบ",
                    style: TextStyle(fontSize: 36, fontFamily: "Mali"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "ชื่อผู้ใช้งาน",
                      labelStyle:
                          const TextStyle(fontSize: 12, fontFamily: "Mali"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "โปรดกรอกชื่อผู้ใช้";
                      } else if (!RegExp(r'^[a-z A-Z 0-9]').hasMatch(value!)) {
                        return "รูปแบบผิดพลาด";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "รหัสผ่าน",
                      labelStyle:
                          const TextStyle(fontSize: 12, fontFamily: "Mali"),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "โปรดกรอกชื่อผู้ใช้";
                      } else if (!RegExp(r'^[a-z A-Z 0-9]').hasMatch(value!)) {
                        return "รูปแบบผิดพลาด";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "ยังไม่มีบัญชี ?",
                        style: TextStyle(fontFamily: "Mali", fontSize: 12),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const Member(); // Return the Login widget
                              },
                            ));
                          },
                          child: const Text(
                            "สร้างบัญชี",
                            style: TextStyle(
                                color: Color.fromARGB(255, 144, 238, 145),
                                fontFamily: "Mali",
                                fontSize: 12),
                          )),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(300, 50)),
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
                    onPressed: () async {
                      var data = {
                        "username": username.text,
                        "password": password.text
                      };
                      Customer customer = Customer.fromJson(data);
                      login(customer, username.text);
                      setState(() {
                        if (fromkey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('ล๊อคอินสำเร็จ'),
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
                                        cusdata.id = cusinfo[0].id;
                                        // print(cusdata.name);
                                        // print(this.cusinfo[0].id);
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
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('แจ้งเตือน'),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("ตรวจสอบชื่อผู้ใช้หรือรหัสผ่านผิด")
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('ตกลง'))
                                ],
                              );
                            },
                          );
                        }
                      });
                    },
                    child: const Text(
                      "เข้าสู่ระบบ",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Mali",
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login(Customer customer, String username) async {
    var response = await http.post(
        Uri.parse("http://10.0.1.132:5000/customer/login"),
        body: jsonEncode(customer),
        headers: {"Content-Type": "application/json"});
    // print(response.body);
    List<Customerinfo> cusinfo = List<Customerinfo>.from(
        json.decode(response.body).map((data) => Customerinfo.fromJson(data)));
    // print(cusinfo[0].name);
    this.cusinfo = cusinfo;
  }

  Future<List<Customerinfo>> select() async {
    var response =
        await http.get(Uri.parse("http://10.0.1.132:5000/customer/select"));
    List<Customerinfo> cusinfo = List<Customerinfo>.from(
        json.decode(response.body).map((data) => Customerinfo.fromJson(data)));
    return cusinfo;
  }
}
