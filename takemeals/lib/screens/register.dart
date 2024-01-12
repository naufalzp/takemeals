import 'package:flutter/material.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';
import 'package:takemeals/widgets/custom_text_form_field.dart';
import 'login.dart';
import 'package:takemeals/network/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _securePasswordText = true;
  bool _secureConfirmPasswordText = true;
  String? name, email, password;

  showHidePass() {
    setState(() {
      _securePasswordText = !_securePasswordText;
    });
  }

  showHideConPass() {
    setState(() {
      _secureConfirmPasswordText = !_secureConfirmPasswordText;
    });
  }

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 31),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Register",
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 5),
                Text(
                  "Welcome!",
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 78),
                CustomTextFormField(
                  controller: fullNameController,
                  hintText: "Name",
                  textInputType: TextInputType.text,
                  validator: (nameValue) {
                    if (nameValue?.isEmpty ?? true) {
                      return 'Please enter your full name';
                    }
                    name = nameValue;
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  validator: (emailValue) {
                    if (emailValue?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    email = emailValue;
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  suffix: IconButton(
                    onPressed: showHidePass,
                    icon: Icon(_securePasswordText
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: 56,
                  ),
                  obscureText: _securePasswordText,
                  contentPadding: EdgeInsets.only(
                    left: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  validator: (passwordValue) {
                    if (passwordValue?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    password = passwordValue;
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  suffix: IconButton(
                    onPressed: showHideConPass,
                    icon: Icon(_secureConfirmPasswordText
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: 56,
                  ),
                  obscureText: _secureConfirmPasswordText,
                  contentPadding: EdgeInsets.only(
                    left: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  validator: (confirmPasswordValue) {
                    if (confirmPasswordValue?.isEmpty ?? true) {
                      return 'Please enter your password';
                    }

                    if (confirmPasswordValue != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 40),
                CustomElevatedButton(
                  width: 160,
                  text: _isLoading ? 'Processing...' : 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _register();
                    }
                  },
                ),
                Spacer(),
                BottomSheet(
                  backgroundColor: Colors.white,
                  onClosing: () {},
                  builder: (context) => Container(
                    color: Colors.white,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: CustomTextStyles.titleSmallOnPrimary,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'name': name, 'email': email, 'password': password};
    var res = await Network().auth(data, 'register');
    var body = jsonDecode(res.body ?? '{}');
    if (res.statusCode == 201) {
      // Store token
      await storage.write(key: 'token', value: jsonEncode(body['token']));

      // Store user
      await storage.write(key: 'user', value: jsonEncode(body['user']));

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      if (body['message'] != null && body['message'] is Map) {
        if (body['message']['name'] != null) {
          if (body['message']['name'] is List &&
              body['message']['name'].isNotEmpty) {
            _showMsg(body['message']['name'][0].toString());
          } else {
            _showMsg(body['message']['name'].toString());
          }
        } else if (body['message']['email'] != null) {
          _showMsg(body['message']['email'][0].toString());
        } else if (body['message']['password'] != null) {
          _showMsg(body['message']['password'][0].toString());
        } else {
          // Handle other message properties if needed
        }
      } else {
        // Handle the case when 'message' is not present or not a map
        // You might want to show a generic error message
        _showMsg("An error occurred. Please try again.");
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
