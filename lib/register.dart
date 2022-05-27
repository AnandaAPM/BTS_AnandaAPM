import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_test/login.dart' as login;
import 'package:http/http.dart'as http ;

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  var email = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();
  String pesan="";

  Future registerAPI(String email,user,pass) async {
    final response = await http.post(
      Uri.parse("${login.url}register"),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }),
      body: jsonEncode({
        "email": email,
        "username":user,
        "password" :pass,
      }));

    var data = jsonDecode(response.body);
    print(data);
    if(data['errorMessage']!=null)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${data["errorMessage"]}"),
    ));
    if(data['statusCode']==2000) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        width: MediaQuery.of(context).size.width*0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Text(pesan),),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: username,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              controller: password,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            MaterialButton(onPressed: (){
              registerAPI(email.text,username.text,password.text);

            },
              child: Text("Register"),
              color: Colors.yellow,
            )
          ],
        ),
      )),
    );
  }


}