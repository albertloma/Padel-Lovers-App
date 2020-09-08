import 'package:get_storage/get_storage.dart';
import 'package:padelloversapp/src/controllers/GetLeagueByKeyController.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'dart:convert';

import 'package:padelloversapp/src/models/CouplePlayers.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:http/http.dart' as http;
import 'package:padelloversapp/src/utils/appInfo.dart';

class GetAllMyLeaguesInfo {
  getLeagueByKeyController getLeagueByKey = getLeagueByKeyController();
  final _storage = GetStorage();
  GetAllMyLeaguesInfo() {}

  Future<List<League>> fetchMyLeaguesInfo() async {
    List<dynamic> keys = _storage.read('myLeagues');
    try {
      keys = _storage.read('myLeagues');

      List<League> listLeague = List<League>();

      for (var key in keys) {
        League league = await getLeagueByKey.fetchLeague(key);
        if (league != null) {
          listLeague.add(league);
        }
      }
      return listLeague;
    } catch (Exception) {}
  }
}
