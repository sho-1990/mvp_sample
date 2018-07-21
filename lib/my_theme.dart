import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final _myTheme = ThemeData(
  primarySwatch: Colors.pink,
  primaryColor: defaultTargetPlatform == TargetPlatform.iOS
    ? Colors.grey[100] : null
);

get myTheme => _myTheme;