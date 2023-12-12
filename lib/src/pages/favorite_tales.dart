import 'package:flutter/material.dart';
import 'package:trip_tales/src/widgets/app_bar_tale.dart';
import 'package:trip_tales/src/widgets/tale_card.dart';

/*
class FavoriteTales extends StatelessWidget {
  final List<CustomTale> allTales;

  FavoriteTales(this.allTales);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Tales'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_tale.jpg'),
          fit: BoxFit.cover,
          /*
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.dstATop,
          ),
          */
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 14,
            child: buildCards(),
          ),
        ],
      ),
    );
  }

  Widget buildCards() {
    List<CustomTale> favoriteTales =
        allTales.where((tale) => tale.isFavorited).toList();

    return SingleChildScrollView(
      child: Column(
        children: favoriteTales.map((tale) {
          return tale;
        }).toList(),
      ),
    );
  }
}
*/

class FavoriteTales extends StatelessWidget {
  final List<CustomTale> allTales;

  FavoriteTales(this.allTales);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAppBar(
        bodyTale: buildBody(),
        showIcon: false,
      ),
      // body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_tale.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3)),

      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 14,
            child: buildCards(),
          ),
        ],
      ),
    );
  }

  Widget buildCards() {
    List<CustomTale> favoriteTales =
        allTales.where((tale) => tale.isFavorited).toList();

    return SingleChildScrollView(
      child: Column(
        children: favoriteTales.map((tale) {
          return tale;
        }).toList(),
      ),
    );
  }
}
