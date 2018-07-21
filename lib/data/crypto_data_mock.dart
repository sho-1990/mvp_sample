import 'dart:async';

import 'package:mvp_sample/data/crypto_data.dart';

class MockCryptoRepository implements CryptoRepository {

  final currencies = <Crypto>[
    Crypto(name: "Bitcoin", priceUsd: "800.60", percentChange1h: "-0.7", symbol: "Btc"),
    Crypto(name: "Ethereum", priceUsd: "650.30", percentChange1h: "0.85", symbol: "Eth"),
    Crypto(name: "Ripple", priceUsd: "300.00", percentChange1h: "-0.25", symbol: "Rip")
  ];

  @override
  Future<List<Crypto>> fetchCurrencies() {
    return Future.value(currencies);
  }

}