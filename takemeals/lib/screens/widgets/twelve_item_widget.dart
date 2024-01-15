import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';

// ignore: must_be_immutable
class TwelveItemWidget extends StatelessWidget {
  const TwelveItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 271,
        width: 350,
      ),
    );
  }
}
