import 'dart:async';

class Crypto {
  String name;
  String priceUsd;
  String percentChange1h;
  String symbol;

  Crypto({ this.name, this.priceUsd, this.percentChange1h, this.symbol });

  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        priceUsd = map['price_usd'],
        percentChange1h = map['percent_change_1h'],
        symbol = map['symbol'];
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final message;
  FetchDataException({ this.message });

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}