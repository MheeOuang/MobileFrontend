import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractor4you/model/customerinfo.dart';
import 'package:http/http.dart' as http;
import '../../DATA/cusdata.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  List<Customerinfo> cusinfo = [];
  @override
  void initState() {
    super.initState();
    loadOwnerData();
  }

  void loadOwnerData() async {
    final cusData = Provider.of<Cusdata>(context, listen: false);
    String id =
        cusData.id.toString(); // Assuming cusData.id is not already a String
    this.cusinfo = await selectCus(id);
    setState(() {});
    // print(owners[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 238, 194),
        title: const Text(
          "โปรไฟล์",
          style: TextStyle(fontFamily: "Mali"),
        ),
      ),
      body: Column(
        children: [
          Text(
            cusinfo[0].username.toString(),
            style: TextStyle(fontFamily: "Mali"),
          ),
          Text(
            cusinfo[0].name.toString(),
            style: TextStyle(fontFamily: "Mali"),
          ),
          Text(
            cusinfo[0].phone.toString(),
            style: TextStyle(fontFamily: "Mali"),
          ),
          Text(
            cusinfo[0].address.toString(),
            style: TextStyle(fontFamily: "Mali"),
          ),
        ],
      ),
    );
  }

  Future<List<Customerinfo>> selectCus(String id) async {
    var response = await http
        .get(Uri.parse("http://10.0.1.132:5000/customer/select/" + id));
    List<Customerinfo> cusinfo = customerinfoFromJson(response.body);
    // print(students[0].name.toString());
    return cusinfo;
  }
}
