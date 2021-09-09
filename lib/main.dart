import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Client? httpClient;
  Web3Client? web3client;
  final myAddress = "";
  String? hash = "";
  var  myData;
  TextEditingController _deposit = TextEditingController();
  TextEditingController _widthdraw = TextEditingController();
  @override
  void initState() {
    super.initState();
  httpClient = Client();
  web3client = Web3Client('https://rinkeby.infura.io/v3/c7cc285dc96d446d9ac203f5b9dddf9f', httpClient!);
    getBalance(myAddress);
  }

  Future<DeployedContract> loadContract() async{
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0x0FAeB44d3F416689e6BFa4534D758B29314e3f07";
    final contract = DeployedContract(ContractAbi.fromJson(abi, 'WaiCoin'),EthereumAddress.fromHex(contractAddress)
    );
    return contract;
  }
  Future<List<dynamic>> query(String functionName,List<dynamic> args) async{
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await web3client!.call(contract: contract, function: ethFunction, params: args);
    return result;
  }
  Future<void> getBalance(String addres) async{
    print('getting');
        List<dynamic> result = await query("getBalance", []);
    myData = result[0];
    print(myData);
    setState(() {
      
    });
  }
  Future<String> submit(String functionName,List<dynamic> args) async{
    EthPrivateKey creditial = EthPrivateKey.fromHex('c72c8f8d41912ce2a2112212a760eb91a0d869c44774cc01295419371a87f9d9');
    DeployedContract contract = await loadContract();
   final ethFunction = contract.function(functionName);
   final result = await web3client!.sendTransaction(creditial, Transaction.callContract(contract: contract, function: ethFunction, parameters: args ),
   fetchChainIdFromNetworkId: true,chainId: null
   );
  print(result);
  setState(() {
     getBalance(myAddress);
  });
  hash = result.toString();
  return result;
  }
  Future<String> getCoin(int amount) async{
      var bigAmount = BigInt.from(amount);
      var response = await submit("depositBalance",[bigAmount]);
      print(response);
      return response;
  }
   Future<String> widthDraw(int amount) async{
      var bigAmount = BigInt.from(amount );
      var response = await submit("widthdrawBalance",[bigAmount]);
      print(response);
      return response;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.all(40),
            children: [
                Center(child: Text('Balance')),
                Center(child: Text(myData == null ? "Loading" : "${myData.toString()} Eth",style: TextStyle(fontSize: 25),)),
                ElevatedButton.icon(
                  onPressed: (){
                       getBalance(myAddress);
                      setState(() {
                        myData = null;
                      });
                  }, 
                  icon: Icon(Icons.refresh), 
                  label: Text('Refresh')),
                  TextField(
                    controller: _deposit,
                    decoration: InputDecoration(
                      hintText: 'Deposit'
                    ),
                  ),

                  ElevatedButton.icon(onPressed: (){
                      getCoin(10);
                      getBalance(myAddress);
                      setState(() {
                        myData = null;
                      });
                  }, 
                  icon: Icon(Icons.add), 
                  label: Text('"Add value"')
                  ),
                  TextField(
                    controller: _widthdraw,
                    decoration: InputDecoration(
                      hintText: 'Widthdraw'
                    ),
                  ),

                  ElevatedButton.icon(onPressed: (){
                      widthDraw(10);
                      getBalance(myAddress);
                      setState(() {
                        myData = null;
                        hash = null;
                      });
                  }, 
                  icon: Icon(Icons.remove), 
                  label: Text('"Withdraw value"')
                  ),
                  Text(hash ==  null ? "Loading" : hash!)

            ],
          ),
      ),
    );
  }
}