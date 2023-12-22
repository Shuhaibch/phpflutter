// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:phpproject/api_connection/api_connection.dart';
import 'package:phpproject/display.dart';
import 'package:phpproject/model/user.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;.
  var name = '';

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  // void getStudents() {
  //   // db.getConnection().then((conn) {
  //   //   String sql = 'select name from student.students where id = 0;';
  //   //   conn.query(sql).then((result) {
  //   //     for (var element in result) {
  //   //       setState(() {
  //   //         name = element[0];
  //   //       });
  //   //     }
  //   //   });
  //   // });
  // }

  Future registerAndSaveUserRecord() async {
    User userModel = User(
      user_Id: int.parse(DateTime.now().millisecond.toString()),
      user_name: nameCtrl.text,
      user_email: emailCtrl.text,
      user_password: passwordCtrl.text,
    );
    try {
      log(userModel.toString());

      var resp =
          await http.post(Uri.parse(Api.signUp), body: userModel.toJson());
      log(resp.statusCode.toString());

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        var result = jsonDecode(resp.body);
        log(resp.statusCode.toString());
        if (result['status'] == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('success')));
          setState(() {
            nameCtrl.clear();
            emailCtrl.clear();
            passwordCtrl.clear();
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              name,
            ),
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
                  registerAndSaveUserRecord();
                },
                child: const Text('submit'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log('message');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Display(),
          ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
