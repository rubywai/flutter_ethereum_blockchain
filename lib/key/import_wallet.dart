import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wai_coin/key/private_key.dart';
import 'package:wai_coin/main.dart';
import 'package:wai_coin/storage.dart';

class ImportWallet extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Import Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Enter Private Key'),
            Divider(),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
            ),
            Divider(),
            TextButton(onPressed: (){
             if(_textEditingController.text.length > 10){
               Storage().saveKey(_textEditingController.text);
               Get.to(Main());
             }

            }, child: Text('Continue'))
          ],
        ),
      ),

    );
  }
}
