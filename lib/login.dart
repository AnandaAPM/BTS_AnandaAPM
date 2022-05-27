import 'dart:convert';

import 'package:app_test/checklist.dart';
import 'package:app_test/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
var token;
var url = "http://94.74.86.174:8080/api/";
class _LoginState extends State<Login> {
  var username = TextEditingController();
  var password = TextEditingController();

  Future loginAPI(String user,pass) async {
    try{
      final response = await http.post(
          Uri.parse("${url}login"),
          headers: ({
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          body:jsonEncode({
            "username":user,
            "password" :pass,
          })
      );

      var data = jsonDecode(response.body);
      token = data['data']['token'];
      print(data);



      if(data['statusCode'] == 2110) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Checklist()));
      }
  }catch(e){
      // print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    token = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: username,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Username",
              ),
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            MaterialButton(onPressed: (){
              loginAPI(username.text, password.text);
            },
              child: Text("Login"),
              color: Colors.green,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
            },
              child: Text("Register"),
              color: Colors.yellow,
            )

          ],
        ),),
      ),
    );
  }

}