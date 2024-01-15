import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/screens/widgets/food_recommendatio_widget.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';
import 'package:takemeals/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class FoodDetailsScreen extends StatelessWidget {
  final Product product;

  FoodDetailsScreen({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1),
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder35,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            SizedBox(
              width: 56,
              child: Divider(
                color: appTheme.black900.withOpacity(0.15),
              ),
            ),
            SizedBox(height: 28),
            _buildFoodDetailsRow(context),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 27),
                child: Row(
                  children: [
                    SizedBox(
                      width: 49,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSignal,
                            height: 16,
                            width: 17,
                            margin: EdgeInsets.only(
                              top: 2,
                              bottom: 1,
                            ),
                          ),
                          Text(
                            "4.3",
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgCart,
                      height: 16,
                      width: 15,
                      margin: EdgeInsets.only(
                        left: 24,
                        top: 2,
                        bottom: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "sold 4 pcs",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 331,
                margin: EdgeInsets.only(
                  left: 27,
                  right: 51,
                ),
                child: Text(
                  "Nasi + 1 Ayam bakar (Potongan ayam yang tersedia tergantung ketersediaan di toko pada saat pemesanan)",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmallOnPrimary_1.copyWith(
                    height: 1.29,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildFoodDetailsColumn(context),
            SizedBox(height: 19),
            _buildFoodDetailsColumn1(context),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFoodDetailsRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ayam Bakar",
            style: theme.textTheme.titleLarge,
          ),
          Text(
            "Rp 10.000",
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFoodDetailsColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 23),
      padding: EdgeInsets.fromLTRB(4, 14, 4, 15),
      decoration: AppDecoration.outlineBlack900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(right: 109),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "Type",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Spacer(),
                Text(
                  ":",
                  style: CustomTextStyles.titleSmallBlack900,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    bottom: 2,
                  ),
                  child: Text(
                    "Makanan Berat",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(right: 182),
            child: Row(
              children: [
                Text(
                  "Stock",
                  style: theme.textTheme.titleSmall,
                ),
                Spacer(),
                Text(
                  ":",
                  style: CustomTextStyles.titleSmallBlack900,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "5 Pcs",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 160),
            child: Row(
              children: [
                Text(
                  "Expired",
                  style: theme.textTheme.titleSmall,
                ),
                Spacer(),
                Text(
                  ":",
                  style: CustomTextStyles.titleSmallBlack900,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "10 Hours",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 23),
                  child: Text(
                    "Location",
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 22),
                  child: Text(
                    ":",
                    style: CustomTextStyles.titleSmallBlack900,
                  ),
                ),
                Container(
                  width: 195,
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    "Jl. Avidya, No 10, Semarang Tengah, Semarang.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 76),
            child: Row(
              children: [
                Text(
                  "Pick Up",
                  style: theme.textTheme.titleSmall,
                ),
                Spacer(),
                Text(
                  ":",
                  style: CustomTextStyles.titleSmallBlack900,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 2,
                  ),
                  child: Text(
                    "Today, 19.00 - 22.00",
                    style: CustomTextStyles.titleSmallInter,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFoodDetailsColumn1(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 9, 24, 10),
      decoration: AppDecoration.outlineBlack9001,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 128,
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.circleBorder20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgGroup3,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 5,
                      ),
                      child: Text(
                        "1",
                        style: CustomTextStyles.titleLargeSemiBold,
                      ),
                    ),
                    CustomIconButton(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                height: 48,
                width: 218,
                text: "Order",
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
              ),
            ],
          ),
          SizedBox(height: 18),
        ],
      ),
    );
  }
}
