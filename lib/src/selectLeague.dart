import 'package:flutter/material.dart';
import 'package:padelloversapp/src/allLeaguesPage.dart';
import 'package:padelloversapp/src/createLeague.dart';
import 'package:padelloversapp/src/utils/appInfo.dart';
import 'package:padelloversapp/src/widgets/itemLeague.dart';
import 'package:padelloversapp/src/widgets/itemResultList.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LeagueSelection extends StatelessWidget {
  const LeagueSelection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectionMenu(context);
  }

  Widget selectionMenu(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleMisLigas(context),
          listaDeLigas(context),
          //buscarLigasbtn2(context),
        ],
      ),
    );
  }

  Widget listaDeLigas(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          children: [
            ItemLeague(),
            ItemLeague(),
            ItemLeague(),
            buscarLigasbtn(context)
          ],
        ),
      ),
    );
  }

  Widget buscarLigasbtn(BuildContext context) {
    return Center(
      child: Column(children: [
        FlatButton(
            highlightColor: Colors.lightGreen[100],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => allLeaguesPage()));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.search,
                color: Colors.lightGreen,
              ),
              Text(
                'BUSCAR LIGAS',
                style: TextStyle(color: Colors.lightGreen),
              )
            ])),
        Padding(padding: EdgeInsets.all(10))
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  Widget TitleMisLigas(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" Mis Ligas", style: Theme.of(context).textTheme.headline1),
              IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 35.0,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateLeaguePage()));
                  }),
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Divider(height: 1)
        ],
      ),
    );
  }

  Widget buscarLigasbtn2(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(
            height: 1,
          ),
          Padding(padding: EdgeInsets.all(5)),
          Container(
            height: 75,
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightGreen, Colors.yellow[600]],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50.0)),
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: 450.0, minHeight: 200.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        "Buscar Ligas",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
