import 'package:blueflower/network/api_helper.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class RecordUpdateController extends ChangeNotifier {
  late Future<List<UserModel>?> futureUsers= APIHelper.apiHelper.fetchData();

  void updateUsers() {
    futureUsers = APIHelper.apiHelper.fetchData();
    notifyListeners();
  }
}
