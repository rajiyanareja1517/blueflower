import 'package:blueflower/network/api_helper.dart';
import 'package:blueflower/provider/record_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/custom_form_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

var _formKey = GlobalKey<FormState>();
TextEditingController fController = TextEditingController();
TextEditingController lController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController mobController = TextEditingController();

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add record"),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: fController,
                  hintText: 'First Name',
                  validator: (val) {
                    if (!val!.isNotEmpty) return 'Enter user name';
                  },
                ),
                CustomFormField(
                  controller: lController,
                  hintText: 'Last Name',
                  validator: (val) {
                    if (!val!.isNotEmpty) return 'Enter user name';
                  },
                ),
                CustomFormField(
                  controller: emailController,
                  hintText: 'Email',
                  validator: (val) {
                    if (!val!.isNotEmpty) return 'Enter user name';
                  },
                ),
                CustomFormField(
                  controller: mobController,
                  hintText: 'Mobile Number',
                  validator: (val) {
                    if (!val!.isNotEmpty) return 'Enter user name';
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        textStyle:
                            WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      _formKey.currentState!.save();
                      await APIHelper.apiHelper.addContact(
                          fName: fController.text,
                          lName: lController.text,
                          email: emailController.text,
                          mobile: mobController.text);
                       ScaffoldMessenger(
                        child: SnackBar(
                            content: Text("Record update successfully!!",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
                      );
                      fController.clear();
                      lController.clear();
                      emailController.clear();
                      mobController.clear();
                      Provider.of<RecordUpdateController>(context,listen: false).updateUsers();
                      Navigator.pushReplacementNamed(context, "home");
                    },
                    child: Text("Submit"))
              ],
            ),
          )),
    );
  }
}
