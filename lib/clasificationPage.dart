import 'package:flutter/material.dart';
import 'package:padelloversapp/widgets/itemClasificacion.dart';
import 'package:padelloversapp/widgets/itemStatistic.dart';

class clasificationPage extends StatelessWidget {
  const clasificationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectionMenu(context);
  }

  Widget selectionMenu(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleClasificacion(context),
          listaClasificacion(context),
          //buscarLigasbtn2(context),
        ],
      ),
    );
  }

  Widget listaClasificacion(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          children: [
            ClasificationItem(
              position: 1,
              player1: 'Alberto Loma',
              player2: 'Elena Fernandez',
              points: 35,
              statisticsItems: [
                StatisticItem(
                  name: 'Puntos',
                  data: '35',
                  isBold: true,
                ),
                StatisticItem(
                  name: 'Ganados',
                  data: '7',
                ),
                StatisticItem(
                  name: 'Perdidos',
                  data: '3',
                ),
                StatisticItem(
                  name: 'Juegos a favor',
                  data: '75',
                ),
                StatisticItem(
                  name: 'Juegos en contra',
                  data: '39',
                ),
              ],
            ),
            ClasificationItem(
              position: 2,
            ),
            ClasificationItem(
              position: 3,
            ),
            ClasificationItem(
              position: 4,
            ),
            ClasificationItem(
              position: 5,
            ),
            ClasificationItem(
              position: 6,
            ),
            ClasificationItem(
              position: 7,
            ),
          ],
        ),
      ),
    );
  }

  Widget buscarLigasbtn(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Theme.of(context).primaryColor,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 6,
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            colors: [Colors.lightGreen, Colors.yellow],
          )),
          child: Center(
            child: Text(
              'Buscar Ligas',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        onPressed: () {});
  }

  // ignore: non_constant_identifier_names
  Widget TitleClasificacion(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" Clasificación",
                  style: Theme.of(context).textTheme.headline1),
              //IconButton(
              //  icon: Icon(Icons.add), iconSize: 35.0, onPressed: () {}),
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
          Divider(height: 1)
        ],
      ),
    );
  }
}
