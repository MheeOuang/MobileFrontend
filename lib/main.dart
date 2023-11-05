import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tractor4you/DATA/cusdata.dart';
import 'package:tractor4you/page/fist/wellcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Cusdata(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 202, 238, 194)),
          useMaterial3: true,
        ),
        home: const wellcome(),
      ),
    );
  }
}
