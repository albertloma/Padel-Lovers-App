import 'package:padelloversapp/src/models/League.dart';
import 'dart:convert';

import 'package:padelloversapp/src/models/CouplePlayers.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:http/http.dart' as http;
import 'package:padelloversapp/src/utils/appInfo.dart';

class getAllLeaguesController {
  getAllLeaguesController() {}

  Future<List<League>> fetchLeagues() async {
    final http.Response response =
        await http.get(appInfo.API_URL + '/ligas.json');

    //JSON LEAGUE DECODE
    List<League> listLeagues = List<League>();
    Map<String, dynamic> myMap = json.decode(response.body);
    for (var key in myMap.keys) {
      //every key is id League
      League newLeague = League();
      newLeague.id = key;
      newLeague.name = myMap[key]['name'];
      newLeague.visibility = myMap[key]['visibility'];
      newLeague.password = myMap[key]['password'];
      listLeagues.add(newLeague);
    }
    return listLeagues;
  }
}
