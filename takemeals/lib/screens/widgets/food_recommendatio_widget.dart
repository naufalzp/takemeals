import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/network/api.dart';

class FoodRecommendationWidget extends StatelessWidget {
  final Product product;

  const FoodRecommendationWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
                    imagePath: product.image,
                    height: 140,
                    fit: BoxFit.cover,
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
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                product.name,
                style: CustomTextStyles.titleMediumBlack900,
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "Stock ${product.stock}",
                style: CustomTextStyles.labelLargeRedA700,
              ),
            ),
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
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(product.price),
                style: CustomTextStyles.titleMediumBlack900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String typeFood;
  final double price;
  final int stock;
  final int expired;
  final String image;

  Product({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.typeFood,
    required this.price,
    required this.stock,
    required this.expired,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      typeFood: json['type_food'],
      price: double.parse(json['price']),
      stock: json['stock'],
      expired: json['expired'],
      image: json['image'],
    );
  }
}
