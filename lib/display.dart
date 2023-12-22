// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:phpproject/edit_screen.dart';
import 'package:phpproject/model/user_from.dart';

import 'api_connection/api_connection.dart';

import 'package:http/http.dart' as http;

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List<UserData> resultList = [];

  @override
  void initState() {
    // await getData();
    log('0');
    super.initState();
  }

  Future getData() async {
    log('message');
    try {
      var resp = await http.get(
        Uri.parse(Api.getall),
      );
      log('333');
      log(resp.statusCode.toString());

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        var result = jsonDecode(resp.body);
        log(resp.statusCode.toString());
        if (result['status'] == true) {
          log(result.toString());
          var results = UserRespo.fromJson(result);
          resultList = results.data;
          // log(results.)
          return resultList;
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text('success')));
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
    }
  }

  Future deleteUser(String user_Id) async {
    log('message');
    try {
      var resp = await http
          .post(Uri.parse(Api.deleteUser), body: {'user_Id': user_Id});
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        var result = jsonDecode(resp.body);
        log(resp.statusCode.toString());
        log(result['status'].toString());
        if (result['status'] == true) {
          setState(() {
            getData();
          });

          // log(results.)
          // return resultList;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('success')));
         
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
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getData();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing c,
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  var resp = resultList[index];
                  return ListTile(
                    title: Text(resp.userName),
                    subtitle: Text(resp.userEmail),
                    trailing: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditScrenn(
                                  email: resp.userEmail,
                                  name: resp.userName,
                                  password: resp.userPassword,
                                  userid: int.parse(resp.userId),
                                ),
                              ));
                            },
                            child: const Icon(Icons.edit)),
                        InkWell(
                            onTap: () {
                              deleteUser(resp.userId);
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              );
            }));
  }
}
