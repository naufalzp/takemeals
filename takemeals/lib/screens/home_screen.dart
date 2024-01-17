import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/network/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:takemeals/screens/food_details_screen.dart';
import 'package:takemeals/screens/widgets/food_recommendatio_widget.dart';
import 'package:takemeals/screens/widgets/partner_widget.dart';

import 'dart:convert';
import 'login_screen.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();
  String name = '';
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;
  Future<List<Product>>? _fetchDataFuture;
  LocationPermission _locationPermission = LocationPermission.denied;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLocationPermission();
    _fetchDataFuture = fetchData();
  }

  _loadUserData() async {
    var userJson = await storage.read(key: 'user');

    if (userJson != null) {
      try {
        Map<String, dynamic> user = jsonDecode(userJson);

        if (user.containsKey('name')) {
          setState(() {
            name = user['name'];
          });
        } else {
          print("Error: 'name' key is missing in user data");
        }
      } catch (e) {
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

  _loadLocationPermission() async {
    // Load the stored location permission status
    String? storedPermission =
        await storage.read(key: 'locationPermissionGranted');

    if (storedPermission != null && storedPermission == 'true') {
      // If permission was granted previously, set the location permission to granted
      setState(() {
        _locationPermission = LocationPermission.always;
      });
    }
  }

  bool get _hasLocationPermission {
    // Check if location permission is granted
    return _locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse;
  }

  void _requestLocationPermission() async {
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }

    setState(() {});

    if (_locationPermission == LocationPermission.always ||
        _locationPermission == LocationPermission.whileInUse) {
      print("Location permission granted");

      // Save the location permission status locally using Flutter Secure Storage
      await storage.write(key: 'locationPermissionGranted', value: 'true');
    } else {
      print("Location permission denied");
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
          onPressed: () {
            _requestLocationPermission();
          },
        ),
        title: _buildTitle(),
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
              SizedBox(height: 32),
              _buildSearchBar(context),
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
                future: _fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _fetchDataFuture = fetchData();
                        });
                      },
                      child: Text('Retry', style: TextStyle(fontSize: 20)),
                    );
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
            icon: SvgPicture.asset(
              ImageConstant.homeFill,
              width: 24,
              height: 24,
              color: _selectedIndex == 0 ? theme.colorScheme.primary : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.dataCheck,
              width: 24,
              height: 24,
              color: _selectedIndex == 1 ? theme.colorScheme.primary : null,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.crowdSourceFill,
              width: 24,
              height: 24,
              color: _selectedIndex == 2 ? theme.colorScheme.primary : null,
            ),
            label: 'Partner',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.personFill,
              width: 24,
              height: 24,
              color: _selectedIndex == 3 ? theme.colorScheme.primary : null,
            ),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTitle() {
    if (_hasLocationPermission) {
      return FutureBuilder<List<Placemark>>(
        future: _getPlacemarks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return skeleton
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print("Error getting location: ${snapshot.error}");
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            String city = snapshot.data![0].locality ?? 'Unknown City';

            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: city,
                    style: CustomTextStyles.titleMediumff232323,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            );
          } else {
            return Text('Unable to get location');
          }
        },
      );
    } else {
      return RichText(
        text: TextSpan(
          text: 'Hi, $name',
          style: CustomTextStyles.titleMediumff232323,
        ),
        textAlign: TextAlign.left,
      );
    }
  }

  Future<List<Placemark>> _getPlacemarks() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return await placemarkFromCoordinates(
        position.latitude, position.longitude);
  }

  Widget _buildSearchBar(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: ShapeDecoration(
            color: Color(0xFFF0F0F0),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.05000000074505806),
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.search_rounded,
                color: Color.fromARGB(99, 35, 35, 35),
                size: 25,
              ),
              SizedBox(width: 5),
              Text(
                'What whould you like?',
                style: TextStyle(
                  color: Color(0x3F232323),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
          itemCount: products.length > 5 ? 5 : products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
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
