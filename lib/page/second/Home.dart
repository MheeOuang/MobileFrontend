// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tractor4you/page/bottom/ListReserve.dart';
import 'package:tractor4you/page/bottom/profile.dart';
import 'package:tractor4you/page/bottom/ListOfOwner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _SelectPageState();
}

class _SelectPageState extends State<Home> {
  int idx = 0;

  final tabs = [
    const ListOfOwner(),
    const ListReserve(),
    const profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded),
              label: 'เจ้าของรถไถ',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_edu),
              label: 'ประวัติ',
              backgroundColor: Colors.green),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person),
          //     label: 'ปรไฟล์',
          //     backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            idx = index;
          });
        },
      ),
    );
  }
}
