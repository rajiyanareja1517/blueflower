import 'package:blueflower/model/user.dart';
import 'package:blueflower/network/api_helper.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
  String id = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(title: Text("Details"),),
      body: FutureBuilder(future: APIHelper.apiHelper.fetchDetails(id: id), builder: (context, snapshot) {
        if(snapshot.hasData){
          print(snapshot.error);
          print(snapshot.data);
          UserModel model=snapshot.data!;
          return Container(
            alignment: Alignment.center,
              child:
              ListTile(
                title: Text("${model.first_name} ${model.last_name}"),
                subtitle: Text(model.email),
              )
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },)



    );
  }
}
