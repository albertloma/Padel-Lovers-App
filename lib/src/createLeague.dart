import 'package:flutter/material.dart';
import 'package:padelloversapp/src/models/CouplePlayers.dart';
import 'package:padelloversapp/src/models/League.dart';

class CreateLeaguePage extends StatefulWidget {
  const CreateLeaguePage({Key key}) : super(key: key);

  @override
  _CreateLeaguePageState createState() => _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {
  League newLeague = new League();
  int _index = 0;
  List<Widget> coupleList = [];
  List<CouplePlayers> coupleListModel = [];

  //LEAGUE INPUT NAME
  final _textKey = GlobalKey<FormState>();
  bool _autovalidate = false;

  bool errorOnPlayesAdd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyCreateLeague(context),
    );
  }

  Widget BodyCreateLeague(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" Crear Liga", style: Theme.of(context).textTheme.headline1),
              FlatButton(
                child: Row(
                  children: [
                    BackButtonIcon(),
                    Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Divider(),
          Container(child: Expanded(child: stepperCreateLeague(context)))
        ],
      ),
    );
    ;
  }

  Widget stepperCreateLeague(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Stepper(
        steps: [
          step1_NombrarLiga(context),
          step2_JugadoresAdd(context),
          Step(
            title: Text("xdd"),
            content: Text("This is our third example."),
          ),
          Step(
            title: Text("Forth"),
            content: Text("This is our forth example."),
          ),
        ],
        currentStep: _index,
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        onStepCancel: () {
          _index = _index;
        },
        onStepContinue: () {
          print(_index);
          if (_index == 0) {
            //STEP 1 - League Name Validation
            if (!_textKey.currentState.validate()) {
              print('invalid');
              return;
            }
          } else if (_index == 1) {
            //STEP 2 - Añadir Jugadores Validation
            bool emptyPlayerFound = false;
            for (var player in coupleListModel) {
              if (player.player1Name == null || player.player1Name == '') {
                emptyPlayerFound = true;
                break;
              } else if (player.player2Name == null ||
                  player.player2Name == '') {
                emptyPlayerFound = true;
                break;
              }
            }

            if (coupleListModel.isEmpty) {
              print('empty players');
              return;
            } else if (emptyPlayerFound) {
              print('empty players fields');
              return;
            }
          }
          if (_index >= 3) return;
          setState(() {
            _index += 1;
          });

          printPlayerList();
        },
      ),
    );
  }

  Step step1_NombrarLiga(BuildContext context) {
    return Step(
      state: StepState.indexed,
      title: Text(
        "Nombra tu Liga",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(children: [
        Text(
          "Primero debes darle un nombre a tu liga. Asegurate que sea reconocible e identificativo.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Form(
          key: _textKey,
          child: TextFormField(
            autovalidate: _autovalidate,
            validator: (value) {
              if (value.isEmpty) {
                return 'Porfavor, rellena este campo';
              }
            },
            decoration: InputDecoration(
              filled: true,
              hintText: '',
              labelText: 'Nombre de Liga',
            ),
            onChanged: (value) {
              setState(() {
                newLeague.name = value;
              });
            },
          ),
        ),
      ]),
    );
  }

  Step step2_JugadoresAdd(BuildContext context) {
    return Step(
      state: StepState.indexed,
      title: Text(
        "Añade Jugadores",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(children: [
        Text(
          "Ahora añade a todas las parejas de jugadores que van a participar en la liga ${newLeague.name == null ? '' : newLeague.name}:",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Column(
          children: coupleList,
        ),
        if (coupleList.length > 0)
          FlatButton(
            highlightColor: Colors.red[100],
            child: const Text(
              'Borrar última pareja',
              style: TextStyle(color: Colors.red, fontSize: 17),
            ),
            onPressed: () {
              setState(() {
                coupleList.removeLast();
                coupleListModel.removeLast();
              });
            },
          ),
        FlatButton(
          highlightColor: Colors.lightGreen[100],
          child: const Text(
            'Añadir nueva pareja',
            style: TextStyle(color: Colors.lightGreen, fontSize: 17),
          ),
          onPressed: () {
            setState(() {
              coupleList.add(coupleNameInputItem(coupleList.length + 1));
              coupleListModel.add(CouplePlayers());
            });
          },
        ),
        Text('Porfavor, completa todos los campos requeridos',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.red, fontSize: 12))
      ]),
    );
  }

  Widget coupleNameInputItem(int coupleNumber) {
    return Container(
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
          ),
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              ListTile(
                title: Text(
                  'Pareja ${coupleNumber}',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre del Jugador 1',
                    ),
                    onChanged: (value) {
                      setState(() {
                        coupleListModel[coupleNumber - 1].player1Name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nombre del Jugador 2',
                    ),
                    onChanged: (value) {
                      setState(() {
                        coupleListModel[coupleNumber - 1].player2Name = value;
                      });
                    },
                  )
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void printPlayerList() {
    int i = 1;
    for (var couple in coupleListModel) {
      print('pareja ' + i.toString());
      print(couple.player1Name + ' and ' + couple.player2Name);
      i++;
    }
  }
}
