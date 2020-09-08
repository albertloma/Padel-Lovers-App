import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:padelloversapp/src/utils/appInfo.dart';

class ItemLeague extends StatefulWidget {
  const ItemLeague({Key key, this.league}) : super(key: key);

  final League league;

  @override
  _ItemLeagueState createState() => _ItemLeagueState();
}

class _ItemLeagueState extends State<ItemLeague> {
  bool isSelected = false;
  final _storage = GetStorage();
  bool _isDeleting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storage.listenKey('currentLeague', (value) {
      if (mounted)
        setState(() {
          isSelected = isThisLeagueSelected();
          if (isSelected) {
            print('---------------SELECTED LEAGUE ' + widget.league.name);
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mounted)
      setState(() {
        isSelected = isThisLeagueSelected();
        if (isSelected) {
          print('---------------SELECTED LEAGUE ' + widget.league.name);
        }
      });
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
      child: Center(
        child: Card(
          color: isSelected ? Colors.lightGreen[200] : Colors.white,
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
                  '${widget.league.name}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text('Visibilidad: ${widget.league.visibility}',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              bottomActionBar()
            ]),
          ),
        ),
      ),
    );
  }

  Widget bottomActionBar() {
    if (!_isDeleting) {
      return ButtonBar(
        children: <Widget>[
          FlatButton(
            highlightColor: Colors.red[100],
            child: const Text(
              'BORRAR',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Borrar Liga'),
                        content: Text(
                            'Dejarás de ver los resultados y puntuaciones de ${widget.league.name}'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar')),
                          FlatButton(
                              onPressed: () {
                                deleteFromMyLeagues();
                                Navigator.of(context).pop();
                              },
                              child: Text('Aceptar'))
                        ],
                      ),
                  barrierDismissible: false);
            },
          ),
          FlatButton(
            highlightColor: Colors.lightGreen[100],
            child: const Text(
              'VER RESULTADOS',
              style: TextStyle(color: Colors.lightGreen),
            ),
            onPressed: () {
              _storage.write('currentLeague', widget.league.id);
            },
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(20),
              child: LinearProgressIndicator(
                backgroundColor: Colors.red[100],
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ))
        ],
      );
    }
  }

  Future<void> deleteFromMyLeagues() async {
    List<dynamic> newKeyList = await _storage.read('myLeagues');

    if (await _storage.read('currentLeague').toString() ==
        widget.league.id.toString()) {
      await _storage.write('currentLeague', 'null');
      print('------------------CURRENT LEAGUE IS ' +
          await _storage.read('currentLeague'));
    }
    //await _storage.write('currentLeague', 'null');
    newKeyList.remove(widget.league.id.toString());
    _storage.write('myLeagues', newKeyList);
  }

  bool isThisLeagueSelected() {
    return _storage.read('currentLeague').toString() == widget.league.id;
  }
}
