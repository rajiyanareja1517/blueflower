class UserModel {
  late String id="";
  late String first_name="";
  late String last_name="";
  late String mobile="";
  late String email="";

  UserModel(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.mobile,
      required this.email});

  factory UserModel.fromJson({required Map data} ) {
    return UserModel(
      id: data['id'] == null?"":  data['id'] ,
      first_name: data['first_name']== null?"":data['first_name'],
      last_name: data['last_name']== null?"":data['last_name'],
      mobile: data['mobile']== null?"": data['mobile'],
      email: data['email']== null?"":data['email'],
    );
  }
}
