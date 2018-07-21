import 'package:flutter/material.dart';
import 'package:mvp_sample/dependency_injection.dart';
import 'package:mvp_sample/home_page.dart';
import 'package:mvp_sample/my_theme.dart';

void main() async {
  Injector.configure(Flavor.PROD);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      home: HomePage(),
    );
  }
}
