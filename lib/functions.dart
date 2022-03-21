import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smautomation/login.dart';
import 'package:smautomation/register.dart';
import 'package:xid/xid.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
Future<User?> CreateAccountFun(
    String name, String phone, String email, String password) async {
  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account Created Successfully");
      await _firestore.collection('Users').doc(_auth.currentUser!.uid).set(
          {"name": name, "phone": phone, "email": email, "password": password});
      return user;
    } else {
      print("account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> LoginFunction(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Login Successfull");
      // print("Generated xid is $xid");
      return user;
    } else {
      print("login failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> PostData(String xid, String PostURL,
    TextEditingController SocialMediaName, DateTime CreatedDate) async {
  try {
    if (User != null) {
      await _firestore
          .collection("Users")
          .doc(_auth.currentUser!.uid)
          .collection("PostData")
          .doc()
          .set({
        "Postid": xid,
        "Posturl": PostURL,
        "CreatedDate": CreatedDate,
        "SocialMediaName": SocialMediaName.text
      });
    }
  } catch (e) {
    print(e.toString());
  }
}
