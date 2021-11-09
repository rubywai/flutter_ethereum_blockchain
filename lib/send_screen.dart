import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wai_coin/key/pending_transaction.dart';
import 'package:wai_coin/qr_view.dart';
import 'package:wai_coin/storage.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'key/private_key.dart';

class SendScreen extends StatefulWidget {
  final Future<DeployedContract> loadContract;
  final Web3Client web3client;



  SendScreen({required this.loadContract,required this.web3client}) ;

  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final TextEditingController textEditingController = TextEditingController();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController priceEditingController = TextEditingController();

  String _result = '';
  String _price = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Enter address or scan '),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                   Get.to(QRViewExample());
                }, icon: Icon(Icons.qr_code_scanner))
              ],
            ),
            SizedBox(height: 50,),
            Text('Enter Price'),
            SizedBox(height: 10,),
            TextField(
              keyboardType: TextInputType.number,
              controller: priceEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              setState((){
                _result = "Sending Please wait....";
              });

              if(textEditingController.text.isNotEmpty && textEditingController.text.length > 10)
                {

                    EthereumAddress address = EthereumAddress.fromHex(
                        textEditingController.text);

                    submit("transfer", [
                      address,
                      BigInt.from(int.parse(priceEditingController.text))
                    ]).then((value) async{
                        _result = "Transaction complete at : $value";
                       List<String> pending = await PendingTransaction().getPendingTransaction();
                       pending.add('$value,${_price}');
                       PendingTransaction().saveTransaction(pending);
                       print('pending is $pending');


                    }).catchError((e){
                      setState(() {
                        _result = "Error : $e";
                      });
                    })
                    ;
                  }


            }, child: Text('Transfer')),
            Text(_result)

          ],
        ),
      ),
    );
  }

  Future<String> submit(String functionName,List<dynamic> args) async{
    String privateKey = await Storage().getKey();
    EthPrivateKey creditial = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await widget.loadContract;
    final ethFunction = contract.function(functionName);
    final result = await widget.web3client.sendTransaction(creditial, Transaction.callContract(contract: contract, function: ethFunction, parameters: args ),
        fetchChainIdFromNetworkId: true,chainId: null
    );
    print("Hash is $result");
    setState((){
      _price  = priceEditingController.text;
      textEditingController.text = "";
      priceEditingController.text = "";
      _result = result;
    });

    return result;
  }
}
