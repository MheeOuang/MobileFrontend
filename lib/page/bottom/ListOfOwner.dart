import 'package:flutter/material.dart';
import 'package:tractor4you/model/ownerinfo.dart';
import 'package:tractor4you/page/second/info/infoOwner.dart';
import 'package:http/http.dart' as http;
import '../second/ownerInfo.dart';

class ListOfOwner extends StatefulWidget {
  const ListOfOwner({super.key, Key? keys});

  @override
  State<ListOfOwner> createState() => _ListOfOwnerState();
}

class _ListOfOwnerState extends State<ListOfOwner> {
  List<Ownerinfo> owners = [];

  @override
  void initState() {
    super.initState();
    loadOwnerData();
  }

  void loadOwnerData() async {
    owners = await selectOwnerData();
    setState(() {});
    print(owners[0].name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 238, 194),
        title: const Text(
          "รายชื่อของเจ้าของรถไถ",
          style: TextStyle(fontFamily: "Mali"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: owners.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  print(owners[index]);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          infoOwner(ownerinfo: owners[index])));
                },
                child: Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  child: Card(
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 75,
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              owners[index].name.toString(),
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 20),
                            ),
                            Text(
                              owners[index].price.toString() + " บาท/ไร่",
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 15),
                            ),
                            Text(
                              "จำนวนคิว " +
                                  owners[index].que.toString() +
                                  " คิว",
                              style:
                                  TextStyle(fontFamily: "Mali", fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: const Color.fromARGB(255, 202, 238, 194),
  //       title: const Text(
  //         "รายชื่อของเจ้าของรถไถ",
  //         style: TextStyle(fontFamily: "Mali"),
  //       ),
  //     ),
  //     body: Container(
  //       padding: EdgeInsets.all(10),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: owners.length,
  //               itemBuilder: (context, index) {
  //                 return Card(
  //                   child: Padding(
  //                     padding: EdgeInsets.all(10),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         ListTile(
  //                           leading: const Icon(
  //                             Icons.person,
  //                             size: 50,
  //                           ),
  //                           subtitle: const Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 owners[index].name,
  //                                 style: TextStyle(fontFamily: "Mali"),
  //                               ),
  //                               Text("500/ไร่",
  //                                   style: TextStyle(fontFamily: "Mali")),
  //                               Text("จำนวนคิว 3",
  //                                   style: TextStyle(fontFamily: "Mali"))
  //                             ],
  //                           ),
  //                           onTap: () {
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (context) {
  //                                   return const infoOwner(); // Return the infoOwner widget
  //                                 },
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<List<Ownerinfo>> selectOwnerData() async {
    var response =
        await http.get(Uri.parse("http://10.0.1.132:5000/owner/select"));
    List<Ownerinfo> owners = ownerinfoFromJson(response.body);
    // print(students[0].name.toString());
    return owners;
  }
}
