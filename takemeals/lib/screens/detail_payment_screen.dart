import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';

class DetailPaymentScreen extends StatelessWidget {
  final Product product;
  final int quantity;

  DetailPaymentScreen({required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Detail Payment'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: _buildBody(context),
      bottomNavigationBar: _buildPayButton(context),
    );
  }

  String limitTextToWords(String text, int maxWords) {
    List<String> words = text.split(' ');

    if (words.length <= maxWords) {
      return text; // Return the original text if it has fewer or equal words than the limit
    } else {
      List<String> truncatedWords = words.sublist(0, maxWords);
      return truncatedWords.join(' ') + '...';
    }
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPickupData(context),
          _buildOrderSummary(context),
        ],
      ),
    );
  }

  Widget _buildPickupData(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadiusStyle.circleBorder20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.timer_rounded,
                      color: Colors.red,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pick Up',
                        style: CustomTextStyles.titleMediumBlack900Bold,
                      ),
                      const SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Today, ',
                              style: CustomTextStyles.titleMediumOnPrimary
                                  .copyWith(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '19.00 - 22.00',
                              style: CustomTextStyles.titleMediumOnPrimary
                                  .copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Positioned(
                top: -20, // Adjust this value to move it higher
                right: 0, // Adjust this value to move it more to the right
                child: SvgPicture.asset(
                  ImageConstant.pickUp,
                  width: 65,
                  height: 65,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.pin_drop_rounded,
                  color: Colors.orange,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pick up from',
                    style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '''
Jl. Avidya, No 10, Gunungpati, 
Semarang''',
                    style: CustomTextStyles.titleMediumBlack900Bold,
                  ),
                  Text(
                    '1.3 km away',
                    style: CustomTextStyles.titleMediumOnPrimary.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE0E0E0),
                      borderRadius: BorderRadiusStyle.circleBorder20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.near_me_rounded,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Direction',
                          style: CustomTextStyles.titleMediumBlack900Bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Order Summary',
                    style: CustomTextStyles.titleLargeBlack900,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusStyle.circleBorder20,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${quantity}x',
                        style: CustomTextStyles.titleLargeBlack900,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    limitTextToWords(product.name, 2), // Limit to 2 words
                    style: CustomTextStyles.titleMediumBlack900Bold,
                    maxLines: 2, // Adjust the number of lines as needed
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(product.price * quantity),
                    style: CustomTextStyles.titleMediumBlack900Bold,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      'Sub total',
                      style: CustomTextStyles.titleSmallOnPrimary,
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(product.price * quantity),
                      style: CustomTextStyles.titleSmallOnPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      'Fee',
                      style: CustomTextStyles.titleSmallOnPrimary,
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(1000),
                      style: CustomTextStyles.titleSmallOnPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(
                color: Colors.black.withOpacity(0.2),
                thickness: 1,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text(
                      'Total',
                      style: CustomTextStyles.titleLargeBlack900,
                    ),
                    Spacer(),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format((product.price * quantity) + 1000),
                      style: CustomTextStyles.titleLargeBlack900,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPayButton(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 9, 24, 10),
        decoration: AppDecoration.outlineBlack9001,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 70,
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusStyle.circleBorder20,
              ),
              child: CustomElevatedButton(
                height: 48,
                width: 175,
                text: "Pay",
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary.copyWith(
                  color: Colors.black,
                ),
                onPressed: () {
                  print("Pay");
                  // Navigate to DetailPaymentScreen with the ordered data
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailPaymentScreen(
                  //       product: widget.product,
                  //       quantity: quantity,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
