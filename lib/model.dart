class TokenResponse {
  String? status;
  String? message;
  List<Result>? result;

  TokenResponse({this.status, this.message, this.result});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  bool pending = false;
  String? blockNumber;
  String? timeStamp;
  String? hash;
  String? nonce;
  String? blockHash;
  String? from;
  String? contractAddress;
  String? to;
  String? value;
  String? tokenName;
  String? tokenSymbol;
  String? tokenDecimal;
  String? transactionIndex;
  String? gas;
  String? gasPrice;
  String? gasUsed;
  String? cumulativeGasUsed;
  String? input;
  String? confirmations;

  Result(
      {this.blockNumber,
        this.timeStamp,
        this.hash,
        this.nonce,
        this.blockHash,
        this.from,
        this.contractAddress,
        this.to,
        this.value,
        this.tokenName,
        this.tokenSymbol,
        this.tokenDecimal,
        this.transactionIndex,
        this.gas,
        this.gasPrice,
        this.gasUsed,
        this.cumulativeGasUsed,
        this.input,
        this.confirmations});

  Result.fromJson(Map<String, dynamic> json) {
    blockNumber = json['blockNumber'];
    timeStamp = json['timeStamp'];
    hash = json['hash'];
    nonce = json['nonce'];
    blockHash = json['blockHash'];
    from = json['from'];
    contractAddress = json['contractAddress'];
    to = json['to'];
    value = json['value'];
    tokenName = json['tokenName'];
    tokenSymbol = json['tokenSymbol'];
    tokenDecimal = json['tokenDecimal'];
    transactionIndex = json['transactionIndex'];
    gas = json['gas'];
    gasPrice = json['gasPrice'];
    gasUsed = json['gasUsed'];
    cumulativeGasUsed = json['cumulativeGasUsed'];
    input = json['input'];
    confirmations = json['confirmations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blockNumber'] = this.blockNumber;
    data['timeStamp'] = this.timeStamp;
    data['hash'] = this.hash;
    data['nonce'] = this.nonce;
    data['blockHash'] = this.blockHash;
    data['from'] = this.from;
    data['contractAddress'] = this.contractAddress;
    data['to'] = this.to;
    data['value'] = this.value;
    data['tokenName'] = this.tokenName;
    data['tokenSymbol'] = this.tokenSymbol;
    data['tokenDecimal'] = this.tokenDecimal;
    data['transactionIndex'] = this.transactionIndex;
    data['gas'] = this.gas;
    data['gasPrice'] = this.gasPrice;
    data['gasUsed'] = this.gasUsed;
    data['cumulativeGasUsed'] = this.cumulativeGasUsed;
    data['input'] = this.input;
    data['confirmations'] = this.confirmations;
    return data;
  }
}