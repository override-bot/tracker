// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:tracker/core/models/user.dart';
import 'package:tracker/core/services/authentication.dart';
import 'package:tracker/core/viewmodels/userviewmodel.dart';
import 'package:tracker/screens/home.dart';
import 'package:tracker/shared/customTextfield.dart';
import 'package:tracker/shared/optimalText.dart';
import 'package:tracker/utils/router.dart';
import 'package:tracker/widgets/popupclass.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final OptimalText _optimalText = OptimalText();
  final Authentication _auth = Authentication();
  final UserViewModel _userViewModel = UserViewModel();
  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  Color blue = Color.fromARGB(255, 14, 140, 172);
  bool isLoading = false;
  bool isLoadingn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_constructors
            children: [
              Text(
                'Register to share your live location',
                style: TextStyle(
                    fontSize: _optimalText.optimizeText(18, context),
                    fontWeight: FontWeight.w600,
                    color: blue),
              ),
              Container(
                height: 15,
              ),
              CustomTextField(
                  hintText: "wisdom",
                  labelText: "Username",
                  controller: _usernameField),
              CustomTextField(
                  hintText: "",
                  obscureText: true,
                  labelText: "Password",
                  controller: _passwordField),
              Container(
                height: 10,
              ),
              Container(
                height: 60,
                color: blue,
                width: MediaQuery.of(context).size.width >= 1200
                    ? MediaQuery.of(context).size.width / 3
                    : MediaQuery.of(context).size.width / 2,
                child: isLoading == false
                    ? MaterialButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          _auth
                              .register(
                                  _usernameField.text, _passwordField.text)
                              .then((user) async {
                            await _userViewModel.addUser(
                                UserModel(
                                    username: _usernameField.text,
                                    lat: 0.0,
                                    long: 0.0),
                                user?.uid);
                            RouteController()
                                .pushAndRemoveUntil(context, MapScreen());
                          }).catchError((e) {
                            if (e.code == "email-already-in-use" ||
                                e.code == "invalid-email") {
                              PopUp().showError("invalid username", context);
                            } else {
                              PopUp().showError(e.code, context);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: OptimalText().optimizeText(16, context),
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              ),
              Container(
                height: 60,
                color: blue,
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width >= 1200
                    ? MediaQuery.of(context).size.width / 2.5
                    : MediaQuery.of(context).size.width / 1.5,
                child: isLoadingn == false
                    ? MaterialButton(
                        onPressed: () async {
                          setState(() {
                            isLoadingn = true;
                          });
                          _auth
                              .signin(_usernameField.text, _passwordField.text)
                              .then((user) {
                            RouteController()
                                .pushAndRemoveUntil(context, MapScreen());
                          }).catchError((e) {
                            PopUp().showError(e.code, context);

                            setState(() {
                              isLoadingn = false;
                            });
                          });
                        },
                        child: Text(
                          "login if you have an account",
                          style: TextStyle(
                              fontSize: OptimalText().optimizeText(16, context),
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
