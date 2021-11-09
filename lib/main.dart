import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wai_coin/create_wallet.dart';
import 'package:wai_coin/key/import_wallet.dart';
import 'package:wai_coin/storage.dart';

import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}
class Main extends StatelessWidget {
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    storage.getKey().then((value){
      print(value);
      if(value != ""){
        Get.offAll(Home());
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text('GSC Wallet'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateWallet()));
            }, child: Text('Create Wallet')),
            TextButton(onPressed: (){
              Get.to(ImportWallet());
            }, child: Text('Import Wallet'))
          ],
        ),
      ),
    );
  }
}

