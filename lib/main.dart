import 'package:flutter/material.dart';
import 'package:prac/screens/pracscreen.dart';

void main() {
  runApp(Practice());
}

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Pracscreen(), debugShowCheckedModeBanner: false);
  }
}
