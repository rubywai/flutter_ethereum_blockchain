import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Storage{
  void saveKey(String privateKey) async{
   final preferences =  await StreamingSharedPreferences.instance;
   Preference<String> key = preferences.getString('key', defaultValue: '');
   key.setValue(privateKey);

  }
  Future<String> getKey() async{
    final preferences =  await StreamingSharedPreferences.instance;
    Preference<String> key = preferences.getString('key', defaultValue: '');
    return key.getValue();
  }
}