import 'package:intl/intl.dart';
import 'package:takemeals/models/partner_model.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/screens/detail_payment_screen.dart';

import './widgets/twelve_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/widgets/app_bar/custom_app_bar.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class FoodDetailsScreen extends StatefulWidget {
  final Product product;
  final Partner partner; // Add this line

  FoodDetailsScreen({
    required this.product,
    required this.partner, // Add this line
  });

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int sliderIndex = 1;

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildImageSection(context),
            _buildRoundedTopContainer(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildOrderButton(context),
    );
  }

  Widget _buildOrderButton(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 9, 24, 10),
        decoration: AppDecoration.outlineBlack9001,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyle.circleBorder20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appTheme.gray600.withOpacity(0.5),
                              width: 1.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          quantity.toString(),
                          style: CustomTextStyles.titleLargeSemiBold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (quantity < widget.product.stock) {
                            setState(() {
                              quantity++;
                            });
                          }
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appTheme.gray600.withOpacity(0.5),
                              width: 1.0, // Adjust the border width as needed
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  height: 48,
                  width: 175,
                  text: "Order",
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle:
                      CustomTextStyles.titleMediumOnPrimary.copyWith(
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Navigate to DetailPaymentScreen with the ordered data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPaymentScreen(
                          product: widget.product,
                          quantity: quantity,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTopContainer(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double remainingHeight = screenHeight - MediaQuery.of(context).padding.top;

    return Transform.translate(
      offset: Offset(0.0, -20.0),
      child: Container(
        height: remainingHeight * 0.545,
        decoration: const BoxDecoration(
          color: Colors.white, // Replace with your desired color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name,
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                      ),
                      Text(
                        'sold 4 pcs',
                        style: CustomTextStyles.titleSmallPrimary_2,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop_rounded,
                        color: Colors.orange,
                      ),
                      Text(
                        '0.8 km',
                        style: CustomTextStyles.titleSmallPrimary_2,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.titleSmallOnPrimary_1.copyWith(
                  height: 1.29,
                ),
              ),
              SizedBox(height: 8),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(widget.product.price),
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Divider(
                color: Colors.black.withOpacity(0.5),
                thickness: 1,
              ),
              SizedBox(height: 16),
              _buildDataSection('Type', widget.product.typeFood),
              SizedBox(height: 8),
              _buildDataSection('Stock', widget.product.stock.toString()),
              SizedBox(height: 8),
              _buildDataSection(
                  'Expired', '${widget.product.expired.toString()} hours'),
              SizedBox(height: 8),
              _buildDataSection('Location', '${widget.partner.address}'),
              SizedBox(height: 8),
              _buildDataSection('Pick Up',
                  'Today, ${widget.partner.openAt} - ${widget.partner.closeAt}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataSection(String label, String value) {
    if (label == 'Location') {
      List<String> lines = [];
      List<String> words = value.split(' ');

      String currentLine = '';
      for (String word in words) {
        if ((currentLine.length + word.length) <= 20) {
          currentLine += '$word ';
        } else {
          if (currentLine.isEmpty) {
            lines.add(word);
          } else {
            lines.add(currentLine.trim());
            currentLine = '$word ';
          }
        }
      }

      if (currentLine.isNotEmpty) {
        lines.add(currentLine.trim());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  label,
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: 10,
                child: Text(
                  ':',
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...lines.map(
                      (line) => Text(
                        line,
                        style: theme.textTheme.titleSmall,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: 10,
            child: Text(
              ':',
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              value,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.left,
            ),
          )
        ],
      );
    }
  }

  /// Section Widget
  Widget _buildImageSection(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double imageHeight = screenHeight * 0.32;
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: imageHeight,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            CustomImageView(
              imagePath: widget.product.image,
              fit: BoxFit.cover,
              height: 358,
              width: 412,
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: imageHeight * 0.9,
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(top: imageHeight * 0.1),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: imageHeight * 0.9,
                        width: MediaQuery.of(context).size.width * 0.85,
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
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        radius: 20,
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => onTapArrowLeft(context),
                              child: Icon(
                                Icons.chevron_left_rounded,
                                color: Colors.black.withOpacity(0.5),
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
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

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
