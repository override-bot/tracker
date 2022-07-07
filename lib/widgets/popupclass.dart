// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PopUp {
  showError(message, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
            content: SizedBox(
                width: MediaQuery.of(context).size.width >= 1200
                    ? MediaQuery.of(context).size.width / 2
                    : MediaQuery.of(context).size.width / 1.1,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dangerous,
                        color: Colors.red,
                        size: 30,
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red[400],
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ])),
          );
        });
  }

  showSuccess(message, context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
            content: SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 30,
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        message,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ])),
          );
        });
  }
}
