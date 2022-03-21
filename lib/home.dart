//import 'package:http/http.dart' as http;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smautomation/actionlist.dart';
import 'package:smautomation/functions.dart';
import 'package:xid/xid.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var UserData;
  TextEditingController socialMediaName = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _firestore.collection("Users").doc(firebaseUser!.uid).get().then((value) {
      setState(() {
        UserData = value.data()!['name'];
      });
    });
    return Scaffold(
        body: Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.only(top: 50, left: 10),
          child: Text(
            "Hare Krishna, $UserData",
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: "Times new roman",
              fontWeight: FontWeight.bold,
            ),
          )),
      const SizedBox(
        height: 20,
      ),
      TextField(
        controller: socialMediaName,
        textAlign: TextAlign.start,
        decoration: const InputDecoration(
            hintText: "Enter Social Media Name",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
      const SizedBox(height: 20),
      RaisedButton(
        onPressed: () {
          String varinurl = socialMediaName.text;
          String url = Uri.https('www.myurl.com', '$varinurl').toString();
          String id = Xid().toString();
          if (socialMediaName.text.isNotEmpty) {
            PostData(id, url, socialMediaName, now);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ActionList(id: id)));
          } else {
            print("field required!");
          }
        },
        color: Colors.blue,
        child: const Text(
          "Create PostData",
          style: TextStyle(
              fontSize: 17.0,
              fontFamily: "Times new roman",
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      )
    ]));
  }
}
