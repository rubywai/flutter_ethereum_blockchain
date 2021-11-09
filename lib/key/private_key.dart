import 'dart:math';

import 'package:web3dart/web3dart.dart';

class CreatePrivateKey {
  Wallet createKey() {
    var rng = Random();
    var random = EthPrivateKey.createRandom(rng);
    var wallet = Wallet.createNew(random, "", rng);
    return wallet;
  }
  Future<String> loadKey({required String privateKey}) async{
    EthPrivateKey creditial = EthPrivateKey.fromHex(privateKey);
    var address =  await creditial.extractAddress();
    return address.hex;
  }

}