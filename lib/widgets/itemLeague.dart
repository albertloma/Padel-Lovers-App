import 'package:flutter/material.dart';

class ItemLeague extends StatelessWidget {
  const ItemLeague({Key key}) : super(key: key);

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
                  'Liga Andrés Gimeno 2020',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text('Fecha Inicio: 3/5/2020',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    highlightColor: Colors.red[100],
                    child: const Text(
                      'BORRAR',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {/* ... */},
                  ),
                  FlatButton(
                    highlightColor: Colors.lightGreen[100],
                    child: const Text(
                      'VER RESULTADOS',
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
