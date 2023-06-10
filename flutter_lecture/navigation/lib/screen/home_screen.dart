import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: MainLayout(title: "Home Screen", children: [
        ElevatedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: Text("Can pop")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text("Maybe pop")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Pop")),
        ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RouteOneScreen(
                  number: 123,
                );
              }));

              print(result);
            },
            child: Text("Push")),
      ]),
    );
  }
}
