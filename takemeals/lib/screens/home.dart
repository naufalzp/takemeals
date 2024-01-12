import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/core/utils/size_utils.dart';
import 'package:takemeals/network/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:takemeals/screens/widgets/frametwentyseven_item_widget.dart';
import 'package:takemeals/screens/widgets/userprofile_item_widget.dart';
import 'package:takemeals/widgets/custom_search_view.dart';
import 'package:takemeals/widgets/app_bar/appbar_leading_image.dart';
import 'dart:convert';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  text: "Semarang, ",
                  style: CustomTextStyles.titleMediumff232323,
                ),
                TextSpan(
                  text: "Indonesia",
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
              _buildFrameTwentySeven(context),
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
              _buildUserProfile(context),
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
  Widget _buildFrameTwentySeven(BuildContext context) {
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
            return FrametwentysevenItemWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 242,
        padding: EdgeInsets.symmetric(vertical: 1),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 31),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 25,
            );
          },
          itemCount: 3,
          itemBuilder: (context, index) {
            return UserprofileItemWidget();
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
    var body = jsonDecode(res.body ?? '{}');
    if (res.statusCode == 200) {
      // Flutter Secure Storage
      await storage.delete(key: "user");
      await storage.delete(key: "token");

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    }
  }
}
