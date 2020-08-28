import 'dart:convert';

import 'package:padelloversapp/src/models/CouplePlayers.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:http/http.dart' as http;
import 'package:padelloversapp/src/utils/appInfo.dart';

class CreateLeagueController {
  CreateLeagueController() {}

  bool validateLeagueInfo(League league) {
    return true;
  }

  Future<http.Response> postLeague(League league) async {
    final http.Response response = await http.post(
      appInfo.API_URL + '/ligas.json',
      body: jsonEncode(<String, String>{
        'name': league.name,
        'visibility': league.visibility,
        'password': league.password,
      }),
    );
    Map<String, dynamic> newLeague = jsonDecode(response.body);
    appInfo.ACTUAL_LEAGUE_ID = newLeague['name'];
    postPlayersLeague(league, newLeague['name']);
  }

  Future<http.Response> postPlayersLeague(
      League league, String leagueId) async {
    for (CouplePlayers players in league.playerList) {
      final http.Response response = await http.post(
        appInfo.API_URL + '/ligas/' + leagueId + '/players.json',
        body: jsonEncode(<String, String>{
          'name1': players.player1Name,
          'name2': players.player2Name
        }),
      );
    }
  }
}
