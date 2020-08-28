import 'dart:convert';

import 'package:padelloversapp/src/models/League.dart';
import 'package:http/http.dart' as http;
import 'package:padelloversapp/src/utils/appInfo.dart';

class CreateLeagueController {
  CreateLeagueController() {}

  bool validateLeagueInfo(League league) {
    return true;
  }

  Future<http.Response> postLeague(League league) {
    return http.post(
      appInfo.API_URL + '/ligas.json',
      body: jsonEncode(<String, String>{
        'name': league.name,
        'visibility': league.visibility,
        'password': league.password,
      }),
    );
  }
}
