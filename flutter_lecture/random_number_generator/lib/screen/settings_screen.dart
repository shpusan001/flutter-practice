import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';

import '../component/number_row.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Body(
                  maxNumber: maxNumber,
                ),
                _Footer(maxNumber: maxNumber, onSliderChanged: onSliderChanged, onPressed: onPressed,)
              ],
            ),
          ),
        ));
  }

  void onSliderChanged(double value) {
    setState(() {
      maxNumber = value.toInt();
    });
  }

  void onPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final int maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber)
    );
  }
}

class _Footer extends StatelessWidget {
  final int maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onPressed;

  const _Footer(
      {required this.maxNumber,
      required this.onSliderChanged,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
            value: maxNumber.toDouble(),
            min: 1000,
            max: 10000 * 100,
            onChanged: onSliderChanged),
        ElevatedButton(
          onPressed: onPressed,
          child: Text("저장!"),
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
        )
      ],
    );
  }
}
