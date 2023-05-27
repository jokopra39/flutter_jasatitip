// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'Detail.dart';
//import 'adddata.dart';
//import 'loginform.dart';
import 'homepage.dart';

class Home extends StatefulWidget {
  @override
  // final String text;
  // Home({Key key, @required this.text}) : super(key: key);
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    String token =
        "4|eO9yjAJKqSC6keLoxViLijvlONV56sx72ZRgIcYC"; //await Candidate().getToken();
    final response =
        await http.get(Uri.parse("http://127.0.0.1:8000/api/posts"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var jsonResponse = json.decode(response.body);

    print(jsonResponse['data']);
    return jsonResponse['data'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "List Data Inventory",
          style: TextStyle(fontFamily: "Netflix"),
        ),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "logout",
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new HomePage()));
              // logout(context);
            },
            // onPressed: () => Navigator.of(context).pushReplacement(
            //   new MaterialPageRoute(
            //       builder: (BuildContext context) => new AddData())),
            label: const Text('Menu'),
            icon: const Icon(Icons.logout),
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            width: 20,
          ),
          //SizedBox(height: 10,),
          FloatingActionButton.extended(
            heroTag: "add data",
            onPressed: () {
              // Navigator.of(context).pushReplacement(new MaterialPageRoute(
              //     builder: (BuildContext context) => new AddData()));
            },
            label: const Text('Tambah Data'),
            icon: const Icon(Icons.add_box),
            backgroundColor: Colors.pink,
          ),
        ],
      ),

      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data!,
                )
              : snapshot.error != null
                  ? new Text("This connection is error")
                  : new Center(
                      child: new CircularProgressIndicator(),
                    );
        },
      ),

      // body: new FutureBuilder<List>(
      //   future: getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) print(snapshot.error);

      //     return snapshot.hasData
      //         ? new ItemList(
      //             list: snapshot.data,
      //           )
      //         : new Center(
      //             child: new CircularProgressIndicator(),
      //           );
      //   },
      // ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: new GestureDetector(
            // onTap: () =>
            //     Navigator.of(context).pushReplacement(new MaterialPageRoute(
            //         builder: (BuildContext context) => new Detail(
            //               list: list,
            //               index: i,
            //             ))),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['content'],
                  style: TextStyle(fontFamily: "Netflix"),
                ),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Stock : ${list[i]['title']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
