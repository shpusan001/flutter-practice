import 'package:flutter/material.dart';

import '../layout/main_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: "Route Three", children: [
      Text(arguments.toString()),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Pop")),
    ]);
  }
}