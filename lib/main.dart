import 'package:flutter/material.dart';
import 'package:flutter_hive_database/model/ogrenci.dart';
import 'package:flutter_hive_database/pages/home_page.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter("uygulama");
  await Hive.openBox("test");
  //*burada test adinda bir kutu ac dedik bu kutuda bizim verilerimiz saklanacak
  //! yoksa olustur varsada onu kullan demis oluyoruz
  Hive.registerAdapter(OgrenciAdapter());
  Hive.registerAdapter(GozRenkAdapter());
  await Hive.openBox<Ogrenci>("ogrenciler");

  await Hive.openLazyBox<int>("sayilar");

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
