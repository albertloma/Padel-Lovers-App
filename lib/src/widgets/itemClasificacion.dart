import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:padelloversapp/src/widgets/itemStatistic.dart';

class ClasificationItem extends StatelessWidget {
  const ClasificationItem(
      {Key key,
      this.position,
      this.player1,
      this.player2,
      this.points,
      this.statisticsItems})
      : super(key: key);

  final int position;
  final String player1;
  final String player2;
  final int points;
  final List<StatisticItem> statisticsItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10.0, left: 10.0),
      child: ExpansionTileCard(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          leading: CircleAvatar(
            child: Text(
              position.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            backgroundColor: ComputeColorByPos(),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player1 == null ? 'player1' : player1,
                ),
                Text(player2 == null ? 'player2' : player2)
              ],
            ),
            Text(
              points == null ? '0' : points.toString(),
              style: TextStyle(fontSize: 20.0),
            )
          ]),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 8.0,
                  ),
                  child: coupleInfo()),
            ),
          ]),
    );
  }

  Color ComputeColorByPos() {
    if (position == 1) {
      return Colors.amber;
    } else if (position == 2) {
      return Colors.grey;
    } else if (position == 3) {
      return Colors.orange[300];
    } else {
      return Colors.lightGreen[200];
    }
  }

  Widget coupleInfo() {
    return Column(
      children: statisticsItems != null ? statisticsItems : [Text('empty')],
    );
  }
}
