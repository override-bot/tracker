import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker/screens/home.dart';
import 'package:tracker/screens/signup.dart';
import 'package:tracker/shared/optimalText.dart';
import 'package:tracker/utils/router.dart';

class Introscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 60,
              color: Colors.blue,
              child: MaterialButton(
                  child: Text(
                    "Tap to get started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: OptimalText().optimizeText(18, context)),
                  ),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      RouteController().pushAndRemoveUntil(context, SignUp());
                    } else {
                      RouteController()
                          .pushAndRemoveUntil(context, MapScreen());
                    }
                  }),
            ),
          )),
    );
  }
}
