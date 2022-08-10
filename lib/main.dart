import 'package:flutter/material.dart';
import 'package:flutter_hive_database/pages/home_page.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter("uygulama");
  await Hive.openBox("test");
  //*burada test adinda bir kutu ac dedik bu kutuda bizim verilerimiz saklanacak
  //! yoksa olustur varsada onu kullan demis oluyoruz
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
