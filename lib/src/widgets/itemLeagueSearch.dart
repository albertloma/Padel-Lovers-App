import 'package:flutter/material.dart';
import 'package:padelloversapp/src/models/League.dart';

class ItemLeagueSearch extends StatelessWidget {
  const ItemLeagueSearch({Key key, this.league}) : super(key: key);

  final League league;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              ListTile(
                title: Text(
                  '${league.name}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text('Visibilidad: ${league.visibility}',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    highlightColor: Colors.lightGreen[100],
                    child: const Text(
                      'AÑADIR A MIS LIGAS',
                      style: TextStyle(color: Colors.lightGreen),
                    ),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
