import 'package:intl/intl.dart';
import 'package:takemeals/screens/widgets/food_recommendatio_widget.dart';

import './widgets/twelve_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:takemeals/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:takemeals/widgets/app_bar/custom_app_bar.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class FoodDetailsScreen extends StatelessWidget {
  final Product product;

  FoodDetailsScreen({required this.product, Key? key}) : super(key: key);

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: 412,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 850,
              width: 412,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _buildTraditionalNasSection(context),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusStyle.roundedBorder35),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 26),
                          _buildFrameThirtyEightSection(context),
                          SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 49,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomImageView(
                                          imagePath:
                                              ImageConstant.imgSignalAmber600,
                                          height: 16,
                                          width: 17,
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 1),
                                        ),
                                        Text("4.3",
                                            style: theme.textTheme.titleSmall)
                                      ],
                                    ),
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgCart,
                                    height: 16,
                                    width: 15,
                                    margin: EdgeInsets.only(
                                        left: 24, top: 2, bottom: 2),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("sold 4 pcs",
                                        style: theme.textTheme.titleSmall),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 331,
                              margin: EdgeInsets.only(left: 4, right: 28),
                              child: Text(
                                product.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.titleSmallOnPrimary_3
                                    .copyWith(height: 1.29),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          _buildFrameSection(context),
                          SizedBox(height: 16),
                          CustomElevatedButton(
                            text: "Add to cart",
                            margin: EdgeInsets.symmetric(horizontal: 7),
                          ),
                          SizedBox(height: 63),
                          SizedBox(width: 108, child: Divider())
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTraditionalNasSection(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 300,
        width: 412,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
                imagePath: product.image,
                fit: BoxFit.cover,
                height: 358,
                width: 412,
                alignment: Alignment.center),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 271,
                width: 350,
                margin: EdgeInsets.only(top: 38),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 271,
                        width: 350,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                  height: 271,
                                  initialPage: 0,
                                  autoPlay: true,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    sliderIndex = index;
                                  }),
                              itemCount: 1,
                              itemBuilder: (context, index, realIndex) {
                                return TwelveItemWidget();
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 20,
                                child: AnimatedSmoothIndicator(
                                  activeIndex: sliderIndex,
                                  count: 1,
                                  axisDirection: Axis.horizontal,
                                  effect: ScrollingDotsEffect(
                                      spacing: 4,
                                      activeDotColor:
                                          appTheme.black900.withOpacity(0.5),
                                      dotColor:
                                          appTheme.black900.withOpacity(0.25),
                                      dotHeight: 8,
                                      dotWidth: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomAppBar(
                      height: 40,
                      leadingWidth: 71,
                      leading: AppbarLeadingIconbutton(
                        imagePath: ImageConstant.imgArrowLeft,
                        margin: EdgeInsets.only(left: 31),
                        onTap: () {
                          onTapArrowLeft(context);
                        },
                      ),
                      actions: [
                        AppbarTrailingIconbutton(
                          imagePath: ImageConstant.imgSend,
                          margin: EdgeInsets.symmetric(horizontal: 31),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameThirtyEightSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.name, style: theme.textTheme.titleLarge),
          Text(
            NumberFormat.currency(
              locale: 'id', // 'id' is the locale code for Indonesia
              symbol: 'Rp',
            ).format(product.price),
            style: theme.textTheme.titleLarge,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 13, 4, 15),
      decoration: AppDecoration.outlineBlack9001,
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
                  child: Text("Type", style: theme.textTheme.titleSmall),
                ),
                Spacer(),
                Text(":", style: CustomTextStyles.titleSmallBlack900),
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 2),
                  child:
                      Text(product.typeFood, style: theme.textTheme.titleSmall),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(right: 182),
            child: Row(
              children: [
                Text("Stock", style: theme.textTheme.titleSmall),
                Spacer(),
                Text(":", style: CustomTextStyles.titleSmallBlack900),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(product.stock.toString(),
                      style: theme.textTheme.titleSmall),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 160),
            child: Row(
              children: [
                Text("Expired", style: theme.textTheme.titleSmall),
                Spacer(),
                Text(":", style: CustomTextStyles.titleSmallBlack900),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(product.expired.toString(),
                      style: theme.textTheme.titleSmall),
                )
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
                  child: Text("Location", style: theme.textTheme.titleSmall),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 22),
                  child: Text(":", style: CustomTextStyles.titleSmallBlack900),
                ),
                Container(
                  width: 195,
                  margin: EdgeInsets.only(left: 16),
                  child: Text("Jl. Avidya, No 10, Semarang Tengah, Semarang.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 76),
            child: Row(
              children: [
                Text("Pick Up", style: theme.textTheme.titleSmall),
                Spacer(),
                Text(":", style: CustomTextStyles.titleSmallBlack900),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 2),
                  child: Text("Today, 19.00 - 22.00",
                      style: CustomTextStyles.titleSmallInter),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
