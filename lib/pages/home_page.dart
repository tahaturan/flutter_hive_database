import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _counter = 0;

  Future<void> _incrementCounter() async {
    var box = Hive.box("test");
    //*ne zaman ki butina basioldiginda biz test kutumuzda islem yapicaz
    //* burada icine islem yapacagimiz kutu adini giriyoruz sen hangi kutuda islem yapmak istiyosun diye soruyor bize
    await box.clear();
    //*kutumuzun icini temizlememizin nedeni uygulamamizi her kapatip actigimizda verilerimiz tekrar tekrar yaziliyor o yuzden asagidaki kodlarimiz calismadan once varolan verileri silelim
    //* await dedik cunku uzun surecek bir islem olabilir bekletmemiz lazim
    box.add("taha"); //*index = 0 ==> key:0 , value:taha
    box.add("turan"); //*index = 1 ==> key:1 , value:turan
    //*eger add ile ekleme yaparsak bu liste seklinde ekleme yani yukarida taha ismini ekledik bunun keyi:0 value:taha dir
    box.add(true); //*index=2 ==> key:2 , value:true
    //*biz kutumuzun ne tur veri tutacagini belitmedigimiz icin icine istedigimiz turde veriler ekleyebiliriz
    box.add(123); //*index=3 ==> key:3 , value:123
    //*Ayni anda birden fazla veri ekleme add ile
    await box.addAll(["veri1", "veri2", 546, false]);
    //*addAll metodu ile liste icinde tek metodla istedigimiz kadar veri ekleyebiliriz kutumuza
    //?----------------------------------------------
    //? Ben bu verileri yazdirmak istersem eger
    // ignore: avoid_function_literals_in_foreach_calls
    box.keys.forEach((element) {
      //* box.keys dersek eger bu bize iterable bir deger veriyor nedir bu deger icinde tek tek elemanlarimizi gezdigimiz veri turu
      //* forech donusu ile elemanlarimizi tek tek gezip konsola yazdiralim
      debugPrint(element.toString());
    });
    //!NOT : Yukarikda forEach dongumuzu for in ilede yapabilirdik hatta boyle kullanmak daha iyidir
/*  for (var element in box.keys) {
      debugPrint(element.toString());
    } */
    debugPrint("******************Value*********************");
    //*Key degerlerimize eristik birde key degerlerimize karsilik gelen value lere eriselim onuda for in ile eriselim
    for (var element in box.values) {
      debugPrint(element.toString());
    }
    //* put medotu veri eklemenin bir diger yontemi :
    await box.put("tc", "1236545635");
    await box.put("tema", "dark");
    //todo: put metodu ise icine kendimiz key ve value degerini veririz add de key degerleri otomatik artan sekilde ilerlerken burada key degerini kendimiz verebiliriz
    //!Not: burada verilerimiz add de oldugu gibi sirali sekilde gelmeyebilir
    //*put metodu ile ayni anda birden fazla veri ekleme:
    await box.putAll({
      "araba": "mercedes",
      //*key - value sekilnde map formatinda ekliyoruz
      "yil": 2022
    });
    debugPrint("---Put metodundan sonra verilerimizin key degerini yazdirdik");
    for (var element in box.values) {
      debugPrint(element.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anasayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$_counter",
              style: const TextStyle(
                fontSize: 70,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
