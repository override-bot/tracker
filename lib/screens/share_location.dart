// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker/core/models/message.dart';
import 'package:tracker/core/models/user.dart';
import 'package:tracker/core/viewmodels/message_view_model.dart';
import 'package:tracker/core/viewmodels/userviewmodel.dart';
import 'package:tracker/shared/optimalText.dart';
import 'package:tracker/utils/router.dart';

class ShareScreen extends StatefulWidget {
  @override
  ShareScreenState createState() => ShareScreenState();
}

class ShareScreenState extends State<ShareScreen> {
  final UserViewModel _userViewModel = UserViewModel();
  final RouteController _routeController = RouteController();
  final OptimalText _optimalText = OptimalText();
  final MessageViewModel _messageViewModel = MessageViewModel();
  User user = FirebaseAuth.instance.currentUser!;
  String? selectedId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
          onPressed: () {
            _routeController.pop(context);
          },
        ),
        actions: [
          selectedId != null
              ? IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    await _messageViewModel.sendMessage(
                        Message(sentId: user.uid), selectedId);
                    _routeController.pop(context);
                  },
                )
              : Container(),
        ],
        title: Text(
          "Select a friend",
          style: TextStyle(
            fontSize: _optimalText.optimizeText(16, context),
            color: Colors.blue,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FutureBuilder<List<UserModel>>(
          future: _userViewModel.getUsers(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: ((context, index) {
                    return Container(
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[100],
                        ),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              selectedId = snapshot.data![index].id;
                            });
                          },
                          title: Text(
                            snapshot.data![index].username!,
                            style: TextStyle(
                              fontSize: _optimalText.optimizeText(15, context),
                              color: selectedId == snapshot.data![index].id
                                  ? Colors.blue
                                  : Color.fromARGB(255, 14, 13, 13),
                            ),
                          ),
                        ));
                  }));
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
