import 'package:blueflower/model/user.dart';
import 'package:blueflower/network_model/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(onPressed: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          Navigator.pushReplacementNamed(context, "login");
        }, icon: Icon(Icons.logout))],
      ),
      body: FutureBuilder(future: APIHelper.apiHelper.fetchData(), builder: (context, snapshot) {
        if(snapshot.hasData){
          List<UserModel> data=[];
         data=snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
              Navigator.pushNamed(context, "detail",arguments:data[index].id )  ;
              },
              child: ListTile(
                title: Text("${data[index].first_name} ${data[index].last_name}"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index].email),
                    Text(data[index].mobile),
                  ],
                ),
              ),
            );
          },);
        }else{
          print(snapshot.error);
          return Center(child: CircularProgressIndicator());
        }
      },),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "add");
      },child: Icon(Icons.add),),
    );
  }
}
