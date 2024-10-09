# blueflower

A blueflower project created in flutter. blueflower supports both ios and android, clone the appropriate branches mentioned below:

* For Mobile: https://github.com/rajiyanareja1517/blueflower
 

Download or clone this repo by using the link below:

```
https://github.com/rajiyanareja1517/blueflower.git
```


```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```


```


### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:blueflower/views/screens/add_screen.dart';
import 'package:blueflower/views/screens/details_screen.dart';
import 'package:blueflower/views/screens/home_screen.dart';
import 'package:blueflower/views/screens/login_screen.dart';
import 'package:blueflower/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>SplashScreen(),
        'home': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'detail': (context) => DetailsScreen(),
        'add': (context) => AddScreen()
      },
    );
  }
}

```
### ApiHelper 

```
import 'dart:convert';

import 'package:blueflower/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIHelper {
  APIHelper._();

  static APIHelper apiHelper = APIHelper._();

  Future<void> login(String userNm, String pass) async {
    http.Response response = await http.post(
        Uri.parse("https://crmcomponentapi.blueflower.in/api/login"),
        body: {"mobile": "$userNm", "password": "$pass"});

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', decodedData['token']);
      print("Token" + decodedData['token']);
      // UserModel user = UserModel.fromJson(decodedData);
      // return user;
    } else {
      print("Error: ${response.statusCode}");
      print("Error1: ${response.body}");

      return null;
    }
  }

  Future<List<UserModel>?> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse("https://crmcomponentapi.blueflower.in/api/contact"),
        headers: {"Authorization": "Bearer ${prefs.getString("token").toString()}"});
    if (response.statusCode == 200) {
      print("response: ${response.body}");
      print("Error: ${response.statusCode}");
      print("Error: ${response.headers}");
      Map decodedData = jsonDecode(response.body);
     // List<Map<dynamic,dynamic>> mapData = decodedData['data'];
      print("response: ${decodedData}");
      //List<UserModel> listData = [];
    /*  for (int i = 0; i < mapData.length; i++) {
        listData.add(UserModel.fromJson(mapData[i]));
      }*/
      List<UserModel> temp = (decodedData['data'] as List).map((e) => UserModel.fromJson(data: e)).toList();
      //listData=mapData.map((e) => UserModel.fromJson(e)).toList();
      return temp;
    } else {
      print("Error: ${response.statusCode}");
      print("Error: ${response.body}");
      print("Error: ${response.headers}");
      return null;
    }

  }

  Future<UserModel?> fetchDetails({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse("https://crmcomponentapi.blueflower.in/api/contact/$id"),
        headers: {"Authorization": "Bearer ${prefs.getString("token").toString()}"});
    if (response.statusCode == 200) {
      print("detail res: ${response.statusCode}");
      print("detail res: ${response.body}");
      print("detail res: ${response.headers}");
      Map decodedData = jsonDecode(response.body);
     UserModel model = UserModel.fromJson(data: decodedData['data'] as Map);
    return model;
    } else {
      print("Error: ${response.statusCode}");
      print("Error: ${response.body}");
      print("Error: ${response.headers}");
      return null;
    }
  }

  Future<void> addContact({required String fName,required String lName,required String email,required String mobile}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = json.encode({
      "first_name": "$fName",
      "last_name": "$lName",
      "email": "$email",
      "mobile": "$mobile",
      "profile": "",
      "contact_types": [
        {"id": "a1dd708a-3db5-11ef-9634-484520bf7692"}
      ],
      "addresses": [
        {
          "address_line_1": "address_line_1",
          "address_line_2": "address_line_2",
          "landmark": "landmark",
          "country_id": "101",
          "state_id": "4030",
          "city": "Rajkot",
          "pincode": "360005",
          "is_default": 1
        }
      ]
    });
    final response = await http.post(
        Uri.parse("https://crmcomponentapi.blueflower.in/api/contact"),
        headers: {"Authorization": "Bearer ${prefs.getString("token").toString()}"},
        body: str);
    if (response.statusCode == 200) {
      print("add res: ${response.statusCode}");
      print("add res: ${response.body}");
      print("add res: ${response.headers}");
     // Map decodedData = jsonDecode(response.body);
     print("ADD:::${response.body}");
    } else {
      print("Error: ${response.statusCode}");
      print("Error: ${response.body}");
      print("Error: ${response.headers}");
      return null;
    }
  }
}

```





https://github.com/user-attachments/assets/b78c45d5-73bc-4bcf-9d54-16fe95cc3fe9

