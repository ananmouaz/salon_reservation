import 'package:flutter/material.dart';

class TitledWidget extends StatelessWidget {
  const TitledWidget(
      {Key? key, required this.title, required this.child, this.textButton})
      : super(key: key);

  final Widget title;
  final Widget child;
  final TextButton? textButton;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textButton != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    title,
                    textButton!
                  ],
                )
              : title,
          child
        ],
      ),
    );
  }
}
