import 'package:flutter/material.dart';

import './MainPage.dart';

void main() => runApp( const ExampleApplication());

class ExampleApplication extends StatelessWidget {
  const ExampleApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage()
      );
  }
}
