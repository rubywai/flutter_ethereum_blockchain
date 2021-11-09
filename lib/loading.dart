import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wai_coin/send_screen.dart';
import 'package:web3dart/web3dart.dart';

class ValueLoading extends StatefulWidget {
  final String myAddress;

  const ValueLoading({required this.myAddress});
  @override
  _ValueLoadingState createState() => _ValueLoadingState(myAddress);
}

class _ValueLoadingState extends State<ValueLoading> {
  Client httpClient =  Client();

  Web3Client? web3client;

  final String myAddress ;

  String? hash = "";

  var  myData;

  _ValueLoadingState(this.myAddress);
  @override
  void initState() {
    super.initState();

    web3client = Web3Client('https://ropsten.infura.io/v3/4c80c6dcc36745e59c312ce01cfa837f', httpClient);
    getBalance();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children : [
        IconButton(onPressed: (){
          setState(() {
            myData = null;
            setState(() {
              getBalance();
            });

          });
        }, icon: Icon(Icons.refresh)),
        Text(myData == null ? "Loading" : "${myData.toString()} GSC Coin",style: TextStyle(fontSize: 25,color: Colors.green),),
        SizedBox(height: 50,),
        IconButton(onPressed: (){
          Get.to(SendScreen(loadContract: loadContract(),web3client: web3client!,));
        }, icon: Icon(Icons.send,color: Colors.blue,))
      ],
    );
  }

  Future<DeployedContract> loadContract() async{
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xdbCc55b73525657D9036CABd92a0711Ea74c4c16";
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'MyToken'),EthereumAddress.fromHex(contractAddress)
    );
    return contract;
  }
  Future<List<dynamic>> query(String functionName,List<dynamic> args) async{
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await web3client!.call(contract: contract, function: ethFunction, params: args);
    return result;
  }
  Future<void> getBalance() async{
    EthereumAddress address = EthereumAddress.fromHex(myAddress);

    List<dynamic> result = await query("balanceOf", [address]);
    myData = result[0];
    print(myData);
    setState(() {

    });
  }


}
