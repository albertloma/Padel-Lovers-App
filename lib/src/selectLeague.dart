import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:padelloversapp/src/allLeaguesPage.dart';
import 'package:padelloversapp/src/createLeague.dart';
import 'package:padelloversapp/src/widgets/itemLeague.dart';
import 'controllers/GetAllMyLeaguesInfo.dart';
import 'models/League.dart';

class LeagueSelection extends StatefulWidget {
  const LeagueSelection({Key key}) : super(key: key);

  @override
  _LeagueSelectionState createState() => _LeagueSelectionState();
}

class _LeagueSelectionState extends State<LeagueSelection> {
  Widget listItemList;

  Timer _timer;

  final getLeagueController = GetAllMyLeaguesInfo();
  final _storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if (mounted) {
      setState(() {
        updateSelectionScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _storage.listenKey('myLeagues', (value) {
      print('STORAGE CHANGEDDDDDDD');
      if (mounted) {
        setState(() {
          updateSelectionScreen();
        });
      }
    });

    if (mounted) {
      setState(() {
        updateSelectionScreen();
      });
    }

    return selectionMenu(context);
  }

  void updateSelectionScreen() {
    setState(() {
      listItemList = FutureBuilder(
          future: getLeagueController.fetchMyLeaguesInfo(),
          builder:
              (BuildContext context, AsyncSnapshot<List<League>> snapshot) {
            if (snapshot.hasData) {
              List<Widget> itemLeagueList = List<Widget>();
              List<League> listLeagues = snapshot.data;
              listLeagues.forEach((element) {
                itemLeagueList.add(ItemLeague(
                  league: element,
                ));
              });

              itemLeagueList.add(buscarLigasbtn(context));
              itemLeagueList.add(FloatingActionButton(
                onPressed: () {
                  print('cleaning memory');
                  _storage.erase();
                  _printKeys();
                },
                backgroundColor: Colors.red,
              ));
              return Container(
                child: Expanded(
                  child: ListView(
                    children: itemLeagueList,
                  ),
                ),
              );
            } else {
              if (_storage.read('myLeagues') == null) {
                return Container(
                  child: Expanded(
                    child: ListView(
                      children: [buscarLigasbtn(context)],
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          });
    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [listItemList],
        ),
      ),
    );
  }

  void _printKeys() {
    List<dynamic> keyList = _storage.read('myLeagues');
    if (keyList == null) {
      print('empty list');
    } else {
      for (var key in keyList) {
        print(key);
      }
    }
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
