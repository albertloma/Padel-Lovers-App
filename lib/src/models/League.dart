import 'package:padelloversapp/src/models/CouplePlayers.dart';

class League {
  String id;
  String name;
  String visibility = 'public';
  String password;
  List<CouplePlayers> playerList;

  League() {}
}
