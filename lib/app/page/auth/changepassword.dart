// import 'dart:convert';

// import 'package:app_api/app/data/sharepre.dart';
// import 'package:app_api/app/model/user.dart';
// import 'package:app_api/app/page/detail.dart';
// import 'package:app_api/mainpage.dart';
import 'package:app_api/app/data/sharepre.dart';
import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/changepass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController _oldPass = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  String temp = '';
  String token = '';
  getcurrenttoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strToken = pref.getString('token')!;
    token = strToken;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrenttoken();
  }

  Future<String> changepass() async {
    return await APIRepository().changePass(
        token, ChangePassM(oldPass: _oldPass.text, newPass: _newPass.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Pass"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Change Pass',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                ChangePassWidget(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          ///String temp = gettoken().toString();
                          String respone = await changepass();
                          if (respone == "ok") {
                            setIndex(3);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Mainpage()));
                          } else {
                            print(respone);
                          }
                        },
                        child: const Text('Done'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController controller, String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: label.contains('word'),
        onChanged: (value) {
          setState(() {
            temp = value;
          });
        },
        decoration: InputDecoration(
            labelText: label,
            icon: Icon(icon),
            border: const OutlineInputBorder(),
            errorText: controller.text.trim().isEmpty ? 'Please enter' : null,
            focusedErrorBorder: controller.text.isEmpty
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))
                : null,
            errorBorder: controller.text.isEmpty
                ? const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red))
                : null),
      ),
    );
  }

  Widget ChangePassWidget() {
    return Column(
      children: [
        textField(_oldPass, "Old Password", Icons.password),
        textField(_newPass, "New Password", Icons.password),
      ],
    );
  }
}
