import 'package:blueflower/views/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';
import '../../network/api_helper.dart';
import '../utils/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var _formKey = GlobalKey<FormState>();
TextEditingController uNmController=TextEditingController();
TextEditingController passController=TextEditingController();


class _LoginScreenState extends State<LoginScreen> {
  void _login() async{
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    await APIHelper.apiHelper.login(uNmController.text, passController.text);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token!=null){
      Navigator.pushReplacementNamed(context, "home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 47),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomFormField(
                  controller: uNmController,
                  hintText: 'User Name',
                  validator: (val) {
                    if (!val!.isNotEmpty) return     'Enter user name';
                  },
                ),
                CustomFormField(
                  controller: passController,
                  hintText: 'Password',
                  validator: (val) {
                    if (!val!.isValidPassword && !val!.isNotEmpty)
                      return 'Enter valid password';
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ButtonStyle(textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      _login();

                    },
                    child: Text("Login"))
              ],
            )),
      ),
    );
  }
}
