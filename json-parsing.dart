import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
  Future? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
    // data?.then((value) {
    //   print(value[0]['title']);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Json Parsing")),
      ),
      body: Center(
        child: Container(
            child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return createListView(snapshot.data, context);
                  } else {
                    return CircularProgressIndicator();
                  }
                })),
      ),
    );
  }

  Future getData() async {
    var data;
    data = Network("https://jsonplaceholder.typicode.com/posts").fetchData();
    return data;
  }

  Widget createListView(data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(
                  height: 5.0,
                  thickness: 3.0,
                ),
                ListTile(
                    title: Text("${data[index]["title"]}"),
                    subtitle: Text("${data[index]["id"]}"),
                    leading: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black26,
                          radius: 23,
                          child: Text("${data[index]["id"]}"),
                        )
                      ],
                    ))
              ],
            );
          }),
    );
  }
}

class Network {
  final String url;

  Network(this.url);
  Future fetchData() async {
    final http.Response response =
        await http.get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
