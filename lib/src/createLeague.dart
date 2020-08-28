import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padelloversapp/src/controllers/CreateLeagueController.dart';
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

  //PLAYER ADD
  bool errorOnPlayesAdd = false;

  //RULES STABLISHMENT
  final _textKeyPassword = GlobalKey<FormState>();
  int _radioValue = 0;
  bool _autovalidatePassword = false;

  //CONTROLLER
  CreateLeagueController createLeagueController = CreateLeagueController();

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
          step3_EstablecerReglas(context),
          step4_Publicar(context),
        ],
        currentStep: _index,
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });

          if (coupleListModel != null) {
            setState(() {
              newLeague.playerList = coupleListModel;
            });
          }
        },
        onStepCancel: () {
          _index = _index;
        },
        onStepContinue: () {
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
              setState(() {
                errorOnPlayesAdd = true;
              });
              return;
            } else if (emptyPlayerFound) {
              print('empty players fields');
              setState(() {
                errorOnPlayesAdd = true;
              });
              return;
            } else {
              newLeague.playerList = coupleListModel;
              setState(() {
                errorOnPlayesAdd = false;
              });
            }
          } else if (_index == 2) {
            if (!_textKeyPassword.currentState.validate()) {
              print('invalid password');
              return;
            }
          }
          if (_index >= 3) {
            if (createLeagueController.validateLeagueInfo(newLeague)) {
              createLeagueController.postLeague(newLeague);
              return;
            } else {
              print('invalid league');
              return;
            }
          }
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
        if (errorOnPlayesAdd)
          Container(
            alignment: Alignment.topLeft,
            child: Text('Porfavor, completa todos los campos requeridos',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)),
          )
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

  Step step3_EstablecerReglas(BuildContext context) {
    return Step(
      state: StepState.indexed,
      title: Text(
        "Establece Reglas",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(children: [
        Text(
          "Ahora debes establecer la contraseña única de 4 dígitos de la liga. Cualquiera que posea esta contraseña podrá ver, añadir y editar resultados:",
          style: Theme.of(context).textTheme.bodyText1,
          softWrap: true,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Form(
          key: _textKeyPassword,
          child: TextFormField(
            autovalidate: _autovalidatePassword,
            validator: (value) {
              if (value.isEmpty) {
                return 'Porfavor, rellena este campo';
              } else if (value.length != 4) {
                return 'Debe contener 4 dígitos';
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(4),
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              filled: true,
              hintText: '',
              labelText: 'Contraseña',
            ),
            onChanged: (value) {
              setState(() {
                newLeague.password = value;
              });
              if (value.length == 4) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          "A continuación decide el tipo de visivilidad y edición de los resultados:",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Row(
          children: [
            Radio(
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Público', style: Theme.of(context).textTheme.bodyText1),
                Container(
                  width: MediaQuery.of(context).size.width / 1.7,
                  child: Text(
                    '(Siempre visible y editable con contraseña)',
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Privado', style: Theme.of(context).textTheme.bodyText1),
                Container(
                  width: MediaQuery.of(context).size.width / 1.7,
                  child: Text(
                    '(Solo visible y editable con contraseña)',
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ]),
    );
  }

  Step step4_Publicar(BuildContext context) {
    return Step(
      state: StepState.indexed,
      title: Text(
        "Publica",
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Column(children: [
        Text(
          "Porfavor revisa la información de la liga que acabas de configurar:",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Nombre: ${newLeague.name == null ? '' : newLeague.name}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Visibilidad: ${newLeague.visibility == null ? '' : newLeague.visibility}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Contraseña: ${newLeague.password == null ? '' : newLeague.password}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        parejasView(context)
      ]),
    );
  }

  Widget parejasView(BuildContext context) {
    if (newLeague.playerList == null || newLeague.playerList.length == 0) {
      return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          "No hay parejas establecidas todavia",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
    }
    List<Widget> parejasViewList = new List<Widget>();
    int i = 1;
    for (CouplePlayers players in newLeague.playerList) {
      parejasViewList.add(muestraPareja(players, i));
      i++;
    }

    return ListView(
      shrinkWrap: true,
      children: parejasViewList,
    );
  }

  Widget muestraPareja(CouplePlayers players, int number) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Pareja ${number.toString()}: ${players.player1Name} y ${players.player2Name}",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0: //public visivility
          newLeague.visibility = 'public';
          break;
        case 1: //private visivility
          newLeague.visibility = 'private';
          break;
      }
    });
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
