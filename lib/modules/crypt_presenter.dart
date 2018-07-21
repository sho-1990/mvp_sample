import 'dart:async';

import 'package:mvp_sample/data/crypto_data.dart';
import 'package:mvp_sample/dependency_injection.dart';

abstract class CryptoListViewContract {
  void onLoadingCrypto(Future<List<Crypto>> items);
}

class CryptoListPresenter {
  CryptoListViewContract _view;
  CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    _repository = Injector().cryptoRepository;
  }

  void loadCurrencies() {
    var items = _repository
        .fetchCurrencies();
    _view.onLoadingCrypto(items);
  }
}