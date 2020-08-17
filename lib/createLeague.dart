import 'package:flutter/material.dart';

class CreateLeaguePage extends StatefulWidget {
  const CreateLeaguePage({Key key}) : super(key: key);

  @override
  _CreateLeaguePageState createState() => _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {
  int _index = 0;

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
          Step(
            state: StepState.indexed,
            title: Text(
              "Nombra tu Liga",
              style: Theme.of(context).textTheme.headline5,
            ),
            content: Text(
              "Primero debes darle un nombre a tu liga. Asegurate que sea reconocible e identificativo.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Step(
            title: Text("Second"),
            content: Text("This is our second example."),
          ),
          Step(
            title: Text("Third"),
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
          print("You are clicking the cancel button.");
        },
        onStepContinue: () {
          setState(() {
            _index += _index;
          });
          print("You are clicking the continue button.");
        },
      ),
    );
  }
}
