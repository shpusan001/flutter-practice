import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class ScheduleButtomSheet extends StatelessWidget {
  const ScheduleButtomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  label: "시작 시간",
                )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: CustomTextField(
                  label: "마감 시간",
                ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: CustomTextField(
              label: "내용",
            ))
          ],
        ),
      ),
    );
  }
}
