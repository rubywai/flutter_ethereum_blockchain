import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wai_coin/storage.dart';


import 'home.dart';
import 'key/private_key.dart';

class CreateWallet extends StatelessWidget {
  CreatePrivateKey createPrivateKey = CreatePrivateKey();
  @override
  Widget build(BuildContext context) {
    String privateKey = _getPrivateKey();
    BigInt mykey =  BigInt.parse(privateKey);
    print(mykey.toRadixString(16));
    return Scaffold(
      appBar: AppBar(title : Text('Create Wallet')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your private key is'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(privateKey,textAlign: TextAlign.center,)),
          ),
          IconButton(onPressed: (){
            Clipboard.setData(ClipboardData(text: privateKey));
          }, icon: Icon(Icons.copy)),
          ElevatedButton(onPressed: (){
            Storage().saveKey(mykey.toRadixString(16));
            Storage().getKey().then((value) => print(value));
            Get.off(Home());
          }, child: Text('Continue'))
        ],
      )

    );
  }
  String _getPrivateKey(){
    return createPrivateKey.createKey().privateKey.privateKeyInt.toString();
  }
}
