import 'package:flutter/material.dart';
import 'package:tractor4you/page/fist/Member.dart';
import 'package:tractor4you/page/fist/login.dart';

class wellcome extends StatelessWidget {
  const wellcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        "สวัสดีครับ",
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: "Mali",
                        ),
                      ),
                      Text(
                        "ยินดีต้อนรับเข้าสู่แอปของเรา",
                        style: TextStyle(fontSize: 16, fontFamily: "Mali"),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 144, 238, 145)),
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                    ),
                  ),
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
                        fontSize: 20, fontFamily: "Mali", color: Colors.black),
                  )),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Color.fromARGB(
                            255, 0, 0, 0), // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const Member(); // Return the Login widget
                      },
                    ));
                  },
                  child: const Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                        fontSize: 16, fontFamily: "Mali", color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
