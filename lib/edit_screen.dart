// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phpproject/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;
import 'package:phpproject/model/user.dart';

class EditScrenn extends StatefulWidget {
  const EditScrenn(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.userid});
  final String name;
  final String email;
  final String password;
  final int userid;

  @override
  State<EditScrenn> createState() => _EditScrennState();
}

class _EditScrennState extends State<EditScrenn> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCtrl = TextEditingController(text: widget.name);
    TextEditingController emailCtrl = TextEditingController(text: widget.email);
    TextEditingController passwordCtrl =
        TextEditingController(text: widget.password);
    log(widget.userid.toString());
    Future updateUserRecord() async {
      User userModel = User(
        user_Id: widget.userid,
        user_name: nameCtrl.text,
        user_email: emailCtrl.text,
        user_password: passwordCtrl.text,
      );
      try {
        // log(userModel.toString());

        var resp =
            await http.post(Uri.parse(Api.editUser), body: userModel.toJson());
        log(resp.statusCode.toString());

        if (resp.statusCode == 200 || resp.statusCode == 201) {
          var result = jsonDecode(resp.body);
          // log(resp.statusCode.toString());
          if (result['status'] == true) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('success')));
            setState(() {
              Navigator.pop(context);
            });
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error2')));
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error3')));
        }
      } catch (e) {
        log(e.toString());

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        rethrow;
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
          ),
          TextField(
            controller: emailCtrl,
          ),
          TextField(
            controller: passwordCtrl,
          ),
          TextButton(
              onPressed: () {
                updateUserRecord();
              },
              child: const Text('submit'))
        ],
      ),
    ));
  }
}
