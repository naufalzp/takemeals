import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: AppDecoration.outlineBlack900.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 140,
                width: 200,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgDeliciousGoula,
                      height: 140,
                      width: 200,
                      radius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 48,
                        margin: EdgeInsets.only(
                          right: 8,
                          bottom: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 4,
                        ),
                        decoration:
                            AppDecoration.fillOnPrimaryContainer1.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder8,
                        ),
                        child: Text(
                          "0.8 km",
                          style: CustomTextStyles.labelMediumOnPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 11),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Goulash ",
                      style: CustomTextStyles.titleMedium18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 50,
                        top: 4,
                        bottom: 4,
                      ),
                      child: Text(
                        "Stock 10",
                        style: CustomTextStyles.labelLargeRedA700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Pick up ",
                        style: theme.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: "Today, ",
                        style: theme.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: "21.00 - 22.00",
                        style: CustomTextStyles.bodySmallInter,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Rp 15.000",
                  style: CustomTextStyles.titleMediumBlack900,
                ),
              ),
              SizedBox(height: 9),
            ],
          ),
        ),
      ),
    );
  }
}
