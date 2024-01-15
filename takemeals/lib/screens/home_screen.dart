import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/core/utils/size_utils.dart';
import 'package:takemeals/network/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:takemeals/screens/food_details_screen.dart';
import 'package:takemeals/screens/widgets/food_recommendatio_widget.dart';
import 'package:takemeals/screens/widgets/partner_widget.dart';
import 'package:takemeals/widgets/custom_search_view.dart';
import 'package:takemeals/widgets/app_bar/appbar_leading_image.dart';
import 'dart:convert';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();
  String name = '';
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    var userJson = await storage.read(key: 'user');

    if (userJson != null) {
      // Check if userJson is not null before decoding
      try {
        Map<String, dynamic> user = jsonDecode(userJson);

        // Check if the 'name' key exists in the decoded map
        if (user.containsKey('name')) {
          setState(() {
            name = user['name'];
          });
        } else {
          // Handle the case where the 'name' key is missing
          // You might want to provide a default value or handle it differently
          print("Error: 'name' key is missing in user data");
        }
      } catch (e) {
        // Handle JSON decoding errors
        print("Error decoding JSON: $e");
      }
    }
  }

  Future<List<Product>> fetchData() async {
    try {
      final response = await Network().getData('products');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['success']) {
          final List<dynamic> productsData = responseData['data'];

          // Convert each product data to a Product object
          List<Product> products = productsData
              .map((productData) => Product.fromJson(productData))
              .toList();

          return products;
        } else {
          throw Exception('Failed to load products');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle errors
      print("Error fetching data: $e");
      throw e; // Rethrow the exception so it can be caught in the FutureBuilder
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leadingWidth: 43,
        leading: IconButton(
          padding: EdgeInsets.only(left: 31, top: 19, bottom: 22),
          icon: Icon(Icons.location_on),
          onPressed: () {},
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 2),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: CustomTextStyles.titleMediumff232323,
                ),
                TextSpan(
                  text: ", Indonesia",
                  style: CustomTextStyles.titleMedium3f232323,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              logout();
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Login()),
              //     (route) => false);
            },
          )
        ],
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 31),
                child: CustomSearchView(
                  autofocus: false,
                  controller: searchController,
                  hintText: "What whould you like?",
                ),
              ),
              SizedBox(height: 32),
              Container(
                height: 136,
                width: 350,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 31),
                  child: Text(
                    "Closest Partner",
                    style: CustomTextStyles.titleMediumBlack900,
                  ),
                ),
              ),
              SizedBox(height: 6),
              _buildPartner(context),
              SizedBox(height: 19),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 31),
                  child: Text(
                    "Food Recommendation",
                    style: CustomTextStyles.titleMediumBlack900,
                  ),
                ),
              ),
              SizedBox(height: 8),
              FutureBuilder(
                future:
                    fetchData(), // Call fetchData to get the list of products
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Use the List of Product objects from the snapshot
                    List<Product> products = snapshot.data as List<Product>;

                    // Call the _buildFoodRecommendation method with the list of products
                    return _buildFoodRecommendation(context, products);
                  }
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Partner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  /// Section Widget
  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //     leadingWidth: 43,
  //     leading: AppbarLeadingImage(
  //       imagePath: ImageConstant.imgLinkedin,
  //       margin: EdgeInsets.only(
  //         left: 31,
  //         top: 19,
  //         bottom: 21,
  //       ),
  //     ),
  //     title: Padding(
  //       padding: EdgeInsets.only(left: 8),
  //       child: RichText(
  //         text: TextSpan(
  //           children: [
  //             TextSpan(
  //               text: "Semarang, ",
  //               style: CustomTextStyles.titleMediumff232323,
  //             ),
  //             TextSpan(
  //               text: "Indonesia",
  //               style: CustomTextStyles.titleMedium3f232323,
  //             ),
  //           ],
  //         ),
  //         textAlign: TextAlign.left,
  //       ),
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildPartner(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 84,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 31),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 24,
            );
          },
          itemCount: 5,
          itemBuilder: (context, index) {
            return PartnerWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFoodRecommendation(
      BuildContext context, List<Product> products) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 250,
        padding: EdgeInsets.symmetric(vertical: 1),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 31),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 25,
            );
          },
          itemCount: products.length,
          itemBuilder: (context, index) {
            // Pass the current product to FoodRecommendationWidget
            return GestureDetector(
              onTap: () {
                // Navigate to FoodDetailsScreen with the selected product
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailsScreen(
                      product: products[index],
                    ),
                  ),
                );
              },
              child: FoodRecommendationWidget(product: products[index]),
            );
            ;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
          border: Border(
            top: BorderSide(
              color: appTheme.black900.withOpacity(0.15),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: appTheme.black900.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(
                0,
                -5,
              ),
            ),
          ],
        ),
        child: Row(
          children: [Icon(Icons.people)],
        ));
  }

  void logout() async {
    String? token = await storage.read(key: 'token');
    var res = await Network().auth(token, 'logout');
    // var body = jsonDecode(res.body ?? '{}');
    if (res.statusCode == 200) {
      // Flutter Secure Storage
      await storage.delete(key: "user");
      await storage.delete(key: "token");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    }
  }
}
