import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class PendingTransaction{
  void saveTransaction(List<String> privateKey) async{
    final preferences =  await StreamingSharedPreferences.instance;
    Preference<List> key = preferences.getStringList('pending', defaultValue: []);
    key.setValue(privateKey);

  }
  Future<List<String>> getPendingTransaction() async{
    final preferences =  await StreamingSharedPreferences.instance;
    Preference<List<String>> key = preferences.getStringList('pending', defaultValue: []);
    return key.getValue();
  }
}