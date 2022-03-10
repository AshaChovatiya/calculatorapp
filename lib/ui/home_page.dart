import 'package:flutter/material.dart';

import 'gst_calculator.dart';
import 'simple_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selecIndex = 0;
  List screen = const [SimpleCalculator(), GstCalculator()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => selecIndex = index),
          currentIndex: selecIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          selectedFontSize: 15,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: "Calculator"),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "GST"),
          ],
        ),
        body: Center(child: screen.elementAt(selecIndex)),
      ),
    );
  }
}
