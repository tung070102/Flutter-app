// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ffi';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

Future<bool> saveUser(User objUser) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = jsonEncode(objUser);
    prefs.setString('user', strUser);
    print("Luu thanh cong: $strUser");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> logOut(BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');
    print("Logout thành công");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

//
Future<User> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String strUser = pref.getString('user')!;
  return User.fromJson(jsonDecode(strUser));
}

Future<bool> setIndex(int index) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('index', index);
    print("Luu thanh cong index: $index");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<Int> getIndex() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  Int index = pref.getInt('index') as Int;
  print("current index: $index");
  return index;
}

Future<bool> saveBillID(String billID) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('billID', billID);
    print("Luu thanh cong: $billID");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
