import 'package:flutter/material.dart';
import 'package:padelloversapp/src/controllers/GetAllLeaguesController.dart';
import 'package:padelloversapp/src/createLeague.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:padelloversapp/src/widgets/itemLeague.dart';
import 'package:padelloversapp/src/widgets/itemLeagueSearch.dart';

class allLeaguesPage extends StatefulWidget {
  const allLeaguesPage({Key key}) : super(key: key);

  @override
  _allLeaguesPageState createState() => _allLeaguesPageState();
}

class _allLeaguesPageState extends State<allLeaguesPage> {
  List<League> listLeagues;
  getAllLeaguesController controller = getAllLeaguesController();

  @override
  Widget build(BuildContext context) {
    return selectionMenu(context);
  }

  Widget selectionMenu(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleMisLigas(context),
            FutureBuilder(
                future: controller.fetchLeagues(),
                builder: (context, AsyncSnapshot<List<League>> snapshot) {
                  if (snapshot.hasData) {
                    return listaDeLigas(context, snapshot.data);
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            //buscarLigasbtn2(context),
          ],
        ),
      ),
    );
  }

  Widget listaDeLigas(BuildContext context, List<League> listLeagues) {
    final searchListItems = List<Widget>();

    listLeagues.forEach((item) {
      searchListItems.add(ItemLeagueSearch(
        league: item,
      ));
    });

    return Container(
      child: Expanded(
        child: ListView(
          children: searchListItems,
        ),
      ),
    );
  }

  Widget TitleMisLigas(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(padding: EdgeInsets.all(16.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(" Todas las ligas",
                style: Theme.of(context).textTheme.headline1),
            IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 35.0,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        Padding(padding: EdgeInsets.all(5)),
        Divider(height: 1)
      ],
    );
  }
}
