import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tractor4you/model/customer.dart';
import 'package:tractor4you/page/fist/login.dart';
import 'package:http/http.dart' as http;

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final GlobalKey<FormState> fromkey = GlobalKey<FormState>();

  final username = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: fromkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  "สมัครสมาชิก",
                  style: TextStyle(fontSize: 36, fontFamily: "Mali"),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      return "โปรดกรอกรหัสผ่าน";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "ชื่อ-นามสกุล",
                    labelStyle:
                        const TextStyle(fontSize: 12, fontFamily: "Mali"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ชื่อ";
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
                  controller: phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "เบอร์โทร",
                    labelStyle:
                        const TextStyle(fontSize: 12, fontFamily: "Mali"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "โปรดกรอกเบอร์โทร";
                    } else if (!RegExp(r'^[0-9]').hasMatch(value!)) {
                      return "รูปแบบผิดพลาด";
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: "ที่อยู่",
                    labelStyle:
                        const TextStyle(fontSize: 12, fontFamily: "Mali"),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ที่อยู่";
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
                      "มีบัญชีแล้ว ?",
                      style: TextStyle(fontFamily: "Mali", fontSize: 12),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const Login(); // Return the Login widget
                            },
                          ));
                        },
                        child: const Text(
                          "เข้าสู่ระบบ",
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
                  onPressed: () {
                    setState(() {
                      if (fromkey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('สมัครสมาชิกสำเร็จ'),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      var data = {
                                        "username": username.text,
                                        "password": password.text,
                                        "phone": phone.text,
                                        "name": name.text,
                                        "address": address.text
                                      };
                                      Customer customer =
                                          Customer.fromJson(data);
                                      createMember(customer);
                                      setState(() {});
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const Login(); // Navigate to the Home widget
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
                                  children: <Widget>[Text("ตรวจสอบข้อมูลใหม่")],
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
                    "สมัครสมาชิก",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Mali",
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createMember(Customer customer) async {
    var response = await http.post(
        Uri.parse("http://10.0.1.132:5000/customer/create"),
        body: jsonEncode(customer),
        headers: {"Content-Type": "application/json"});
    print(response.body);
  }
}
