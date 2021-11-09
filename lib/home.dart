import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wai_coin/key/private_key.dart';
import 'package:wai_coin/storage.dart';
import 'package:wai_coin/transaction.dart';
import 'package:web3dart/web3dart.dart';

import 'loading.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Storage storage = Storage();

  CreatePrivateKey createPrivateKey = CreatePrivateKey();
  String myAddress = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
           Get.to(TransactionScreen(address: myAddress,));
          }, icon: Icon(Icons.history))
        ],
        title: Text(''),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              color: Colors.blue,
              height: 200,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                   "Address is \n\n $myAddress",
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: myAddress));
                      },
                      icon: Icon(Icons.copy,color: Colors.white,)),

                ],
              ),
            ),
            Center(
              child: QrImage(
                data: myAddress,
                version: QrVersions.auto,
                size: 100.0,
              ),
            ),
            Divider(),
            ListTile(leading: Icon(Icons.exit_to_app),title: Text('Exit'),
              onTap: (){
                 Storage().saveKey("");
                 Get.to(Main());
              },
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          FutureBuilder<String>(
              future: storage.getKey(),
              builder: (context, snapshot) {
                String privateKey = snapshot.data ?? '';
                return Center(
                    child: FutureBuilder<String>(
                  future: createPrivateKey.loadKey(privateKey: privateKey),
                  builder: (context, snapshot) {
                    myAddress = snapshot.data ?? '';
                    if (snapshot.hasData)
                      return Column(
                        children: [
                          Text('You have'),
                          SizedBox(
                            height: 50,
                          ),
                          ValueLoading(myAddress: myAddress),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Your address is $myAddress",
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: myAddress));
                              },
                              icon: Icon(Icons.copy)),
                          QrImage(
                            data: myAddress,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ],
                      );
                    else
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  },
                ));
              }),
        ],
      ),
    );
  }
}
