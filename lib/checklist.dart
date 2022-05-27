import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Checklist extends StatefulWidget {
  // const Checklist({Key? key}) : super(key: key);

  Checklist({Key? key}) : super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  // var tkn = int.parse(token);
  var x;

  Future getChecklistAPI() async {
    final response = await http.get(
      Uri.parse("${url}checklist"),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      }),
    );
    var data = jsonDecode(response.body);
    print(data['data']);
    setState(() {
      x = data['data'];

    });

  }
  Future createChecklistAPI(String name) async {
    final response = await http.post(
      Uri.parse("${url}checklist"),
      headers: ({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      }),
      body: jsonEncode({
        "name" : name,
      })
    );
    var data = jsonDecode(response.body);
    print(data['data']);
    setState(() {
      x = data['data'];

    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.green,
            child: MaterialButton(
              onPressed: () {

              },
              child: Text("Tambah Checklist"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.7,
              child: ListView.builder(
                itemCount: x.length,
                shrinkWrap: true,
            itemBuilder: (context, index) => Card(
              child:  Container(
                height: 100,
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(x[index]['name']),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    getChecklistAPI();
  }
}
