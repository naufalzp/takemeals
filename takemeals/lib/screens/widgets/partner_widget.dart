import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/models/partner_model.dart';

// ignore: must_be_immutable
class PartnerWidget extends StatelessWidget {
  final Partner partner;

  const PartnerWidget({Key? key, required this.partner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: appTheme.red500,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
            ),
            SizedBox(height: 6),
            Text(
              partner.storeName,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
