import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Checklist extends StatefulWidget {
  const Checklist({Key? key}) : super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  var tkn = int.parse(token);
  Future getChecklistAPI() async {
    final response = await http.get(
        Uri.parse("${url}checklist"),
        headers: ({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color:Colors.green,
            child: MaterialButton(
            onPressed: (){

            },
            child: Text("Tambah Checklist"),
          ),)
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