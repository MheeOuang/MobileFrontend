import 'package:flutter/material.dart';

class OwnerInfo extends StatefulWidget {
  const OwnerInfo({Key? key}) : super(key: key);

  @override
  State<OwnerInfo> createState() => _OwnerInfoState();
}

class _OwnerInfoState extends State<OwnerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียด",
          style: TextStyle(fontFamily: "Mali"),
        ),
      ),
    );
  }
}
