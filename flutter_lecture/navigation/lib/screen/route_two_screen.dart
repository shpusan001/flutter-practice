import 'package:flutter/material.dart';
import 'package:navigation/screen/route_three_screen.dart';

import '../layout/main_layout.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: "Route Two", children: [
      Text(
        "arguments: ${arguments}",
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Pop")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/three", arguments: 999);
          },
          child: Text("Push Named")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => RouteThreeScreen()));
          },
          child: Text("Push replacement")),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RouteThreeScreen()), (route)=>route.settings.name == "/");
          },
          child: Text("Push and remove until"))
    ]);
  }
}
