import 'dart:convert';

import 'package:padelloversapp/src/models/League.dart';
import 'package:padelloversapp/src/models/CouplePlayers.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:http/http.dart' as http;
import 'package:padelloversapp/src/utils/appInfo.dart';

class getLeagueByKeyController {
  getLeagueByKeyController() {}

  Future<League> fetchLeague(String key) async {
    final http.Response response =
        await http.get(appInfo.API_URL + '/ligas/' + key + '.json');

    //JSON LEAGUE DECODE
    if (response.body == 'null') {
      print('a null on request');
      return null;
    }

    Map<String, dynamic> myMap = json.decode(response.body);

    League newLeague = League();
    newLeague.id = key;
    newLeague.name = myMap['name'];
    newLeague.visibility = myMap['visibility'];
    newLeague.password = myMap['password'];

    print('LEAGUE SAVED INFO:');
    print(newLeague.id);
    print(newLeague.name);
    print(newLeague.password);
    print(newLeague.visibility);

    return newLeague;
  }
}
