import 'package:flutter/material.dart';
import 'package:wai_coin/model.dart';

class TransactionDetail extends StatelessWidget {
  final Result result;
  final bool isOwn;

  const TransactionDetail({required this.result,required this.isOwn});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(result.timeStamp!) * 1000);
    return Scaffold(
      appBar: AppBar(title: Text(result.hash ?? ''),),
      body: ListView(
        children: [
          SizedBox(height: 50,),
          Center(
            child: isOwn ? Icon(Icons.arrow_upward,color: Colors.red,)
                : Icon(Icons.arrow_downward,color: Colors.green,),
          ),
          ListTile(
            title: Text('From'),
            subtitle: Text(result.from ?? '',style: TextStyle(color:  isOwn ? Colors.blue : Colors.black),),
          ),
          ListTile(
            title: Text('To'),
            subtitle: Text(result.to ?? '',style: TextStyle(color:  !isOwn ? Colors.blue : Colors.black)),
          ),
          ListTile(
            title: Text('Value'),
            subtitle: Text(result.value ?? ''),
          ),
          ListTile(
            title: Text('Unit'),
            subtitle: Text('GSC Coin'),
          ),
          ListTile(
            title: Text('Time'),
            subtitle: Text('${date.day}/${date.month}/${date.year}/  ${date.hour}:${date.minute}:${date.second}'),
          )
        ],
      ),
    );
  }
}
