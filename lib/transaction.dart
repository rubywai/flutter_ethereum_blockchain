import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wai_coin/key/pending_transaction.dart';
import 'package:wai_coin/model.dart';
import 'package:wai_coin/transaction_detail.dart';

class TransactionScreen extends StatefulWidget {
  final String address;

  const TransactionScreen({required this.address});

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _pending = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title : Text('Transaction..')),
      body: FutureBuilder<Response>(
        future: getTransactions(widget.address),
        builder: (context,snapshot){
          if(snapshot.hasData) {

            TokenResponse token = TokenResponse.fromJson(snapshot.data!.data);
            token.result = token.result!.reversed.toList();
            PendingTransaction().getPendingTransaction().then((value){
              for(int i=0;i<value.length;i++) {
                token.result?.forEach((element) {
                  if(element.hash == value[i].split(",")[0]){
                    value.removeAt(i);
                  }
                });
              }
              print(value);
               if(value.length > 0)
              _pending = value[0];
               else
                 _pending = '';
              PendingTransaction().saveTransaction(value);
              print(_pending.length);
              setState(() {

              });

            });
            return Column(
              children: [

                Expanded(
                  flex: 8,
              child: ListView.builder(
              itemCount: token.result!.length,
                  itemBuilder: (context, index) {

                    return Card(
                      elevation: 0,
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              TransactionDetail(isOwn : (token.result![index].from! == widget.address),result: token.result![index],)));
                        },
                        leading: (token.result![index].from! == widget.address) ? Icon(Icons.arrow_upward,color: Colors.red,)
                            : Icon(Icons.arrow_downward,color: Colors.green,),
                        title: Text(token.result![index].hash ?? ''),
                        subtitle: Text('${token.result![index].value!} GSC Coin',style: TextStyle(
                            color: (token.result![index].from! == widget.address) ? Colors.red : Colors.green
                        ),),
                      ),
                    );
                  }),
            ),
                Expanded(
                  flex: 2,
                  child: (_pending !=  '' ) ? Card(
                    child: ListTile(
                      leading : Text('Pending..'),
                      subtitle: Text(
                          'To ${_pending.split(",")[0]}'),
                      title: Text(
                          'Hash ${_pending.split(",")[1]}'
                      ),
                    ),
                  ) : Center(child: Text('No pending transaction'))
                ),
              ],
            );
          }
          else if(snapshot.hasError)
            return Center(child: Text('Error..'),);
          else return Center(child: CircularProgressIndicator());
        },
      )

    );
  }
}
Future<Response> getTransactions(String address,){
  Dio dio = Dio();
  return dio.get('https://api-ropsten.etherscan.io/api?module=account&action=tokentx&address=$address&startblock=0endblock=99999999&page=1&offset=1000&sort=asc&apikey=XXGW2K916V3RX486KI9JNHZQUXD5R2GA1A');



}
