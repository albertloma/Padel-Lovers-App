import 'dart:async';

import 'package:flutter/material.dart';
import 'package:padelloversapp/src/models/League.dart';
import 'package:padelloversapp/src/utils/appInfo.dart';

class ItemLeagueSearch extends StatefulWidget {
  const ItemLeagueSearch({Key key, this.league}) : super(key: key);

  final League league;

  @override
  _ItemLeagueSearchState createState() => _ItemLeagueSearchState();
}

class _ItemLeagueSearchState extends State<ItemLeagueSearch> {
  String textButton = '';
  TextStyle textStyle = TextStyle(color: Colors.white);
  int justCreated = 0;

  Timer _timer;

  @override
  Widget build(BuildContext context) {
    _updateTextOnButton();
    _timer = new Timer(const Duration(milliseconds: 800), () {
      if (this.mounted) {
        setState(() {
          _updateTextOnButton();
        });
      }
    });

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
                  '${widget.league.name}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text('Visibilidad: ${widget.league.visibility}',
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    highlightColor: Colors.lightGreen[100],
                    child: Text(textButton, style: textStyle),
                    onPressed: !_isThisLeagueOnStorage()
                        ? () => _addKeyLocalStorage()
                        : null,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _updateTextOnButton() {
    if (_isThisLeagueOnStorage()) {
      setState(() {
        textButton = 'SIGUENDO';
        textStyle = TextStyle(color: Colors.grey);
      });
    } else {
      setState(() {
        textButton = 'AÑADIR A MIS LIGAS';
        textStyle = TextStyle(color: Colors.lightGreen);
      });
    }
  }

  void _addKeyLocalStorage() {
    List<dynamic> keyList = appInfo.storage.getItem('myLeagues');
    if (keyList == null) {
      //if is empty, create the storage and add the first value
      List<String> newKeyList = List<String>();
      newKeyList.add(widget.league.id);
      appInfo.storage.setItem('myLeagues', newKeyList);
      _updateTextOnButton();
      _printKeys();
    } else {
      //is not empty
      if (!keyList.contains(widget.league.id)) {
        //if storage dont contain the key add it
        keyList.add(widget.league.id);
        appInfo.storage.setItem('myLeagues', keyList);
        _updateTextOnButton();
        _printKeys();
      } else {
        print('value already in storage');
      }
    }
  }

  bool _isThisLeagueOnStorage() {
    List<dynamic> keyList = appInfo.storage.getItem('myLeagues');
    if (keyList == null) {
      print('empty list');
      return false;
    } else {
      return keyList.contains(widget.league.id);
    }
  }

  void _printKeys() {
    List<dynamic> keyList = appInfo.storage.getItem('myLeagues');
    if (keyList == null) {
      print('empty list');
    } else {
      for (var key in keyList) {
        print(key);
      }
    }
  }
}
