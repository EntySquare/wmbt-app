import 'package:flutter/material.dart';
import 'package:wmbt/widgets/setI10n/WmbtDropdownButton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SwitchLanguage();
  }
}
