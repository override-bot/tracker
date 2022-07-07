import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tracker/core/models/message.dart';
import 'package:tracker/core/models/user.dart';
import 'package:tracker/core/viewmodels/message_view_model.dart';
import 'package:tracker/core/viewmodels/userviewmodel.dart';
import 'package:tracker/utils/router.dart';

import '../shared/optimalText.dart';

class Received extends StatelessWidget {
  RouteController _routeController = RouteController();
  MessageViewModel _messageViewModel = MessageViewModel();
  UserViewModel _userViewModel = UserViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            _routeController.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FutureBuilder<List<Message>>(
            future: _messageViewModel.getLocations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                          stream: _userViewModel
                              .streamUserById(snapshot.data![index].sentId),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                              return Container(
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[100],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '${snapshot.data!['username']} shared location',
                                      style: TextStyle(
                                        fontSize: OptimalText()
                                            .optimizeText(15, context),
                                        color: Color.fromARGB(255, 14, 13, 13),
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${snapshot.data!['lat']}  ${snapshot.data!['long']}',
                                      style: TextStyle(
                                        fontSize: OptimalText()
                                            .optimizeText(15, context),
                                        color: Color.fromARGB(255, 14, 13, 13),
                                      ),
                                    ),
                                  ));
                            } else {
                              return Container(
                                margin: EdgeInsets.all(15),
                                color: Colors.white,
                                height: 10,
                                width: MediaQuery.of(context).size.width,
                              );
                            }
                          });
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }
            }),
      ),
    );
  }
}
