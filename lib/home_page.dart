import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvp_sample/data/crypto_data.dart';
import 'package:mvp_sample/modules/crypt_presenter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {

  CryptoListPresenter _presenter;
  Future<List<Crypto>> _currencies;

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _HomePageState() {
    _presenter = CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadCurrencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MVP Sample App"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 1.0 : 5.0,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    if (_currencies == null) {
      return Container();
    }
    return FutureBuilder(
      future: _currencies,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: FlatButton.icon(
              onPressed: () {
              _presenter.loadCurrencies();
              },
              label: Text("Reload"),
              icon: Icon(Icons.refresh),
              color: Theme.of(context).accentColor,
            ),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Crypto> cryptoItems = snapshot.data;

        return Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: cryptoItems.length,
                  itemBuilder: (context, int index) {
                    final int i = index ~/ 2;
                    final Crypto currency = cryptoItems[index];
                    final MaterialColor color = _colors[i % _colors.length];
                    return _getListItemUi(currency, color);
                  },
                ),
              ),
            ],
          ),
        );

      },
    );
  }

  Widget _getListItemUi(Crypto currency, MaterialColor color) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Image.network(
              "https://rawgit.com/atomiclabs/cryptocurrency-icons/master/32@2x/color/${currency.symbol.toLowerCase()}@2x.png"),
          ),
          title: Text(currency.name, style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: _getSubtitleText(currency.priceUsd, currency.percentChange1h)
        ),
      ],
    );
  }


  _getSubtitleText(String priceUsd, String percentChange1h) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUsd\n", style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentChange1h%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentChange1h) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }

    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));

  }

  @override
  void onLoadingCrypto(Future<List<Crypto>> items) {
    setState(() {
      _currencies = items;
    });
  }


}


