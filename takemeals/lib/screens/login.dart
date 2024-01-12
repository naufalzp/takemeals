import 'package:flutter/material.dart';
import 'package:takemeals/network/api.dart';
import 'package:takemeals/core/app_export.dart';
import 'package:takemeals/widgets/custom_elevated_button.dart';
import 'package:takemeals/widgets/custom_text_form_field.dart';
import 'register.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  var email, password;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
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
                  "Login",
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 5),
                Text(
                  "Welcome back!",
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 78),
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
                    }),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  suffix: IconButton(
                    onPressed: showHide,
                    icon: Icon(
                        _secureText ? Icons.visibility_off : Icons.visibility),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: 56,
                  ),
                  obscureText: _secureText,
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
                SizedBox(height: 40),
                CustomElevatedButton(
                  width: 160,
                  text: _isLoading ? 'Processing...' : 'Login',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
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
                          "Don’t have an account yet?",
                          style: CustomTextStyles.titleSmallOnPrimary,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            'Register',
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};
    // API call
    var res = await Network().auth(data, 'login');
    var body = jsonDecode(res.body ?? '{}');
    if (res.statusCode == 200) {
      // Store token
      await storage.write(key: 'token', value: jsonEncode(body['token']));

      // Store user
      await storage.write(key: 'user', value: jsonEncode(body['user']));

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
