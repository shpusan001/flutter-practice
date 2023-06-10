import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("버튼"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Button Style"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }
                      return Colors.red;
                    }),
                    padding: MaterialStateProperty.resolveWith(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return EdgeInsets.all(100);
                      }
                      return EdgeInsets.all(20);
                    })),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("ElevetedButton"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.black,
                    shadowColor: Colors.green,
                    elevation: 10,
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    padding: EdgeInsets.all(32.0),
                    side: BorderSide(color: Colors.black, width: 4.0)),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text("OutLinedButton"),
                style: OutlinedButton.styleFrom(
                  primary: Colors.green,
                  backgroundColor: Colors.yellow,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("TextButton"),
                style: TextButton.styleFrom(
                    primary: Colors.brown, backgroundColor: Colors.blue),
              )
            ],
          ),
        ));
  }
}
