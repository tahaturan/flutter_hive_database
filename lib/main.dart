import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive_database/model/ogrenci.dart';
import 'package:flutter_hive_database/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("uygulama");
  //*Sifreleme Encryted
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: "key");

  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: "key", value: base64UrlEncode(key));
  }

  var encryptionKey =
      base64Url.decode(await secureStorage.read(key: "key") ?? "taha");

  debugPrint("EncryptionKey : $encryptionKey");

  var sifreliKutu = await Hive.openBox("ozel",
      encryptionCipher: HiveAesCipher(encryptionKey));
  await sifreliKutu.put("secret", "hive is cool");
  await sifreliKutu.put("sifre", "123654");
  debugPrint(sifreliKutu.get("secret"));
  debugPrint(sifreliKutu.get("sifre"));

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
