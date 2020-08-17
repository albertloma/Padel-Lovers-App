import 'package:flutter/material.dart';
import 'package:padelloversapp/widgets/itemResultList.dart';

class resultPage extends StatelessWidget {
  const resultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bodyHomePage(context),
    );
  }

  Widget bodyHomePage(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: EdgeInsets.all(16.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" Resultados", style: Theme.of(context).textTheme.headline1),
              IconButton(
                  icon: Icon(Icons.add), iconSize: 35.0, onPressed: () {})
            ],
          ),
          Divider(),
          Container(child: Expanded(child: listResultsView(context)))
        ],
      ),
    );
  }

  Widget listResultsView(BuildContext context) {
    return ListView(
      children: [
        itemResult(),
        itemResult(),
        itemResult(),
        itemResult(),
      ],
    );
  }
}
