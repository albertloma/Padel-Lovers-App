import 'dart:math';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class itemResult extends StatelessWidget {
  List<String> imagesURI = [
    'images/banner.jpg',
    'images/banner2.jpg',
    'images/banner3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: cardMatch(context));
  }

  Widget cardMatch(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            //Image.asset("",
            //    fit: BoxFit.cover),
            ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0)),
                child: Image.asset(randomImagePicker(), fit: BoxFit.cover)),
            ListTile(
              title: Text(
                'Partido 32',
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text('3/5/2020',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              couplePeople(context),
              verticalDividerCustom(context),
              matchResult(context),
              verticalDividerCustom(context),
              couplePeople(context)
            ]),
          ]),
        ),
      ),
    );
  }

  Widget couplePeople(BuildContext context) {
    return Column(children: [
      Text('Jugador 1', style: Theme.of(context).textTheme.bodyText1),
      Text('Jugador 2', style: Theme.of(context).textTheme.bodyText1)
    ]);
  }

  Widget matchResult(BuildContext context) {
    return Column(
      children: [
        Text('6-2', style: Theme.of(context).textTheme.headline4),
        Text('7-5', style: Theme.of(context).textTheme.headline4),
      ],
    );
  }

  Widget verticalDividerCustom(BuildContext context) {
    return Container(height: 80, child: VerticalDivider(color: Colors.grey));
  }

  String randomImagePicker() {
    Random random = Random();
    int index = random.nextInt(imagesURI.length);
    return imagesURI[index];
  }
}
