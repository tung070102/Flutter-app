import 'package:flutter/material.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/forgetpass.dart';
import 'package:app_api/app/page/auth/login.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  String temp = '';

  Future<String> forgetpass() async {
    return await APIRepository().forgetPass(ForgetPassM(
        accountID: _accountController.text,
        numberID: _numberIDController.text,
        newPass: _newPass.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Pass"),
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
                    'Forget Pass Info',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                ForgetPassWidget(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          String respone = await forgetpass();
                          if (respone == "ok") {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => _Dialog(),
                            // );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
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

  Widget ForgetPassWidget() {
    return Column(
      children: [
        textField(_accountController, "Account", Icons.person),
        textField(_numberIDController, "NumberID", Icons.key),
        textField(_newPass, "New Password", Icons.password),
      ],
    );
  }
}
