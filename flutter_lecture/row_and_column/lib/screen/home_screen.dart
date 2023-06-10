import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // MainAxisAlignment - 주축 정렬
            // start - 시작
            // end - 끝
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            //CrossAxisAlignment - 반대축 정렬
            crossAxisAlignment: CrossAxisAlignment.center,

            //MainAxisSize = 주축의 크기
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.red,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.orange,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.yellow,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.green,
                      width: 50.0,
                      height: 50.0,
                    )
                  ],
                ),
              ),
              Container(
                child: Container(
                  color: Colors.orange,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.red,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.orange,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.yellow,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Container(
                      color: Colors.green,
                      width: 50.0,
                      height: 50.0,
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.green,
                width: 50.0,
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
